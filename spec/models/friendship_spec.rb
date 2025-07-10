require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user_a) { FactoryBot.create(:user) }
  let(:user_b) { FactoryBot.create(:user) }

  describe 'Friendship logic' do
    describe '.send_friend_request' do
      context 'when no friendship exists' do
        it 'creates a new friendship with status created' do
          expect {
            Friendship.send_friend_request(user_a, user_b)
          }.to change(Friendship, :count).by(1)

          friendship = Friendship.last
          expect(friendship.sender).to eq(user_a)
          expect(friendship.receiver).to eq(user_b)
          expect(friendship.status).to eq('created')
        end
      end

      context 'when existing friendship was declined_by_sender' do
        it 'updates status to created' do
          friendship = Friendship.create!(sender: user_a, receiver: user_b, status: 'declined_by_sender')
          Friendship.send_friend_request(user_a, user_b)
          expect(friendship.reload.status).to eq('created')
        end
      end

      context 'when existing reverse friendship was declined_by_receiver' do
        it 'does not create new friendship' do
          Friendship.create!(sender: user_b, receiver: user_a, status: 'declined_by_receiver')
          expect {
            Friendship.send_friend_request(user_a, user_b)
          }.not_to change(Friendship.find_by(sender: user_b, receiver: user_a), :status)
        end
      end

      context 'when existing friendship was declined_by_sender' do
        it 'updates status to created' do
          Friendship.create!(sender: user_b, receiver: user_a, status: 'declined_by_receiver')
          Friendship.send_friend_request(user_a, user_b)
          expect(Friendship.find_by(sender: user_a, receiver: user_b).status).to eq('created')
          expect(Friendship.find_by(sender: user_b, receiver: user_a)).to eq nil
        end
      end

      context 'when existing reverse friendship was declined_by_receiver' do
        it 'does not create new friendship' do
          Friendship.create!(sender: user_a, receiver: user_b, status: 'declined_by_sender')
          expect {
            Friendship.send_friend_request(user_a, user_b)
          }.not_to change(Friendship.find_by(sender: user_a, receiver: user_b), :status)
        end
      end
    end

    describe '.accept_friend_request' do
      it 'sets status to active if friendship exists and not declined_by_receiver' do
        friendship = Friendship.create!(sender: user_b, receiver: user_a, status: 'created')
        Friendship.accept_friend_request(user_a, user_b)
        expect(friendship.reload.status).to eq('active')
      end

      it 'does not update if friendship is declined_by_receiver' do
        friendship = Friendship.create!(sender: user_b, receiver: user_a, status: 'declined_by_receiver')
        Friendship.accept_friend_request(user_a, user_b)
        expect(friendship.reload.status).to eq('declined_by_receiver')
      end
    end

    describe '.decline_friend_request' do
      context 'when current user is sender of friendship' do
        it 'sets status to declined_by_sender' do
          friendship = Friendship.create!(sender: user_a, receiver: user_b, status: 'created')
          Friendship.decline_friend_request(user_a, user_b)
          expect(friendship.reload.status).to eq('declined_by_sender')
        end
      end

      context 'when current user is receiver of friendship' do
        it 'sets status to declined_by_receiver' do
          friendship = Friendship.create!(sender: user_b, receiver: user_a, status: 'created')
          Friendship.decline_friend_request(user_a, user_b)
          expect(friendship.reload.status).to eq('declined_by_receiver')
        end
      end
    end
  end

  describe 'User friendship helpers' do
    before do
      Friendship.send_friend_request(user_a, user_b)
    end

    context '#friend_users' do
      it 'returns users with active friendships' do
        Friendship.accept_friend_request(user_b, user_a)
        expect(user_a.friend_users).to include(user_b)
        expect(user_b.friend_users).to include(user_a)
      end
    end

    context '#pending_friend_requests' do
      it 'returns requests waiting for acceptance' do
        expect(user_b.pending_friend_requests.map(&:sender)).to include(user_a)
        expect(user_a.pending_friend_requests).to be_empty
      end
    end

    context '#declined_by_me' do
      it 'returns friendships declined by current user' do
        Friendship.decline_friend_request(user_b, user_a) # user_b odrzuca zaproszenie od user_a
        expect(user_b.declined_by_me).not_to be_empty
        expect(user_a.declined_by_me).to be_empty
      end
    end

    context '#declined_by_others' do
      it 'returns friendships declined by others' do
        Friendship.decline_friend_request(user_b, user_a)
        expect(user_a.declined_by_others).not_to be_empty
        expect(user_b.declined_by_others).to be_empty
      end
    end
  end
end
