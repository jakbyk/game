# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Chat.find_or_create_by!(play_id: nil)
BudgetCategory.seed
Event.create!(
  title: "Społeczny nacisk na budowę połączenia kolejowego",
  description: "Społeczeństwo Olsztyna domaga się wybudowania nowego połączenia kolejowego z Gdańskiem. Aktywiści i lokalni politycy apelują o uwzględnienie projektu w planach transportowych.",
  frequency: 45,
  region: "Pomorskie",
  budget_name: "Transport i łączność",
  budget_change: 1100,
  is_adding_to_budget: true,
  positive_description: "Fundusze pokryją koszta budowy nowego połączenia kolejowego.",
  negative_description: "Według naszych wieści z Olsztyna, wciąż nie będzie szybkiego połączenia do Gdańska."
)
Event.create!(
  title: "Związki nauczycielskie domagają się podwyżek",
  description: "Związki zawodowe ogłosiły protest i żądają zwiększenia wynagrodzeń dla nauczycieli szkół podstawowych i średnich.",
  frequency: 70,
  region: "Mazowieckie",
  budget_name: "Oświata i wychowanie",
  budget_change: 850,
  is_adding_to_budget: true,
  positive_description: "Nauczyciele otrzymali wyczekiwane podwyżki, co poprawiło morale w szkołach.",
  negative_description: "Rząd odmówił wsparcia – protesty trwają, a morale w oświacie spada."
)
Event.create!(
  title: "Propozycja racjonalizacji wydatków wojskowych",
  description: "Niektórzy posłowie postulują ograniczenie zakupu nowego uzbrojenia, wskazując na niższe napięcia międzynarodowe.",
  frequency: 50,
  region: nil,
  budget_name: "Obrona narodowa",
  budget_change: 1200,
  is_adding_to_budget: false,
  positive_description: "Zaoszczędzono środki bez negatywnego wpływu na bezpieczeństwo kraju.",
  negative_description: "Zmniejszenie inwestycji budzi zaniepokojenie ekspertów ds. obronności."
)
Event.create!(
  title: "Miasta chcą więcej środków na zieleń",
  description: "Związek Miast Polskich apeluje o wsparcie programu rewitalizacji parków i terenów zielonych w aglomeracjach.",
  frequency: 60,
  region: "Wielkopolskie",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 600,
  is_adding_to_budget: true,
  positive_description: "Zrewitalizowane parki poprawiły jakość życia mieszkańców.",
  negative_description: "Brak środków pogłębia problemy z zielenią i jakością powietrza w miastach."
)
Event.create!(
  title: "Ministerstwo zapowiada restrukturyzację administracji",
  description: "Planowana jest redukcja zatrudnienia w urzędach centralnych poprzez cyfryzację i automatyzację procedur.",
  frequency: 55,
  region: nil,
  budget_name: "Administracja publiczna",
  budget_change: 700,
  is_adding_to_budget: false,
  positive_description: "Zmniejszono wydatki bez pogorszenia jakości obsługi obywateli.",
  negative_description: "Automatyzacja nie działa jak należy – obywatele skarżą się na chaos w urzędach."
)
Event.create!(
  title: "Strażacy wnioskują o zakup nowego sprzętu",
  description: "OSP i PSP apelują o środki na modernizację wozów bojowych oraz szkolenia ratownicze.",
  frequency: 65,
  region: "Podkarpackie",
  budget_name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa",
  budget_change: 1000,
  is_adding_to_budget: true,
  positive_description: "Nowoczesny sprzęt zwiększył skuteczność straży pożarnej.",
  negative_description: "Władze odmówiły finansowania – pojawiają się problemy z gotowością bojową."
)
Event.create!(
  title: "Kontrowersyjna propozycja cięcia dotacji dla klubów sportowych",
  description: "Część posłów twierdzi, że zbyt dużo środków trafia do mało efektywnych organizacji sportowych.",
  frequency: 45,
  region: nil,
  budget_name: "Kultura fizyczna",
  budget_change: 300,
  is_adding_to_budget: false,
  positive_description: "Zaoszczędzono środki bez większego wpływu na lokalne kluby.",
  negative_description: "Cięcia spowodowały zamknięcie niektórych szkółek sportowych."
)
Event.create!(
  title: "Hospicja domagają się zwiększenia finansowania",
  description: "Organizacje zajmujące się opieką paliatywną proszą o zwiększenie dotacji z powodu rosnących kosztów leków i opieki.",
  frequency: 50,
  region: "Małopolskie",
  budget_name: "Ochrona zdrowia",
  budget_change: 750,
  is_adding_to_budget: true,
  positive_description: "Zwiększone finansowanie poprawiło jakość opieki nad chorymi terminalnie.",
  negative_description: "Brak środków zmusił hospicja do ograniczenia przyjęć pacjentów."
)
Event.create!(
  title: "Nowa ustawa o stypendiach dla studentów",
  description: "Rząd rozważa uproszczenie systemu stypendiów oraz zmniejszenie budżetu poprzez likwidację mniej efektywnych programów.",
  frequency: 40,
  region: nil,
  budget_name: "Szkolnictwo wyższe i nauka",
  budget_change: 500,
  is_adding_to_budget: false,
  positive_description: "Oszczędności bez szkody dla najbardziej potrzebujących studentów.",
  negative_description: "Cięcia uderzyły w studentów z mniej zamożnych rodzin."
)
Event.create!(
  title: "Lokalne samorządy chcą kampanii promującej turystykę",
  description: "Włodarze gmin turystycznych proszą o fundusze na ogólnopolską kampanię promującą atrakcje Polski.",
  frequency: 30,
  region: "Małopolskie",
  budget_name: "Turystyka",
  budget_change: 250,
  is_adding_to_budget: true,
  positive_description: "Wzrost liczby turystów poprawił sytuację lokalnych przedsiębiorców.",
  negative_description: "Kampania nie przyniosła oczekiwanych rezultatów – zmarnowane środki."
)
Event.create!(
  title: "Eksperci proponują ograniczenie rezerw budżetowych",
  description: "Niektórzy ekonomiści wskazują, że zbyt wysokie rezerwy ograniczają elastyczność finansową państwa.",
  frequency: 50,
  region: nil,
  budget_name: "Administracja publiczna",
  budget_change: 10,
  is_adding_to_budget: false,
  budget_reserve_change: 1000,
  need_increase_budget_reserve: false,
  positive_description: "Zmniejszenie rezerw pozwoliło uwolnić środki na inne potrzeby.",
  negative_description: "Brak rezerw utrudnił reakcję na niespodziewane kryzysy."
)
Event.create!(
  title: "Wzrost liczby wypadków drogowych w regionie",
  description: "Województwo dolnośląskie apeluje o zwiększenie środków na poprawę infrastruktury i bezpieczeństwa ruchu drogowego.",
  frequency: 60,
  region: "Dolnośląskie",
  budget_name: "Transport i łączność",
  budget_change: 900,
  is_adding_to_budget: true,
  positive_description: "Nowe inwestycje poprawiły bezpieczeństwo na drogach.",
  negative_description: "Brak działań pogłębia problem – liczba wypadków rośnie."
)
Event.create!(
  title: "Apel o wsparcie dla domów kultury",
  description: "Lokalne domy kultury proszą o wsparcie finansowe na organizację wydarzeń i modernizację sprzętu.",
  frequency: 55,
  region: "Lubelskie",
  budget_name: "Kultura i ochrona dziedzictwa narodowego",
  budget_change: 400,
  is_adding_to_budget: true,
  positive_description: "Dzięki dotacjom ośrodki kultury znów tętnią życiem.",
  negative_description: "Bez wsparcia wiele domów kultury zawiesza działalność."
)
Event.create!(
  title: "Plan likwidacji przestarzałych kopalni",
  description: "Ministerstwo energii planuje zamknięcie kilku nieefektywnych kopalni węglowych, co może przynieść oszczędności.",
  frequency: 50,
  region: "Śląskie",
  budget_name: "Górnictwo i kopalnictwo",
  budget_change: 1000,
  is_adding_to_budget: false,
  positive_description: "Zmniejszono koszty i rozpoczęto transformację energetyczną regionu.",
  negative_description: "Zamknięcie kopalń bez osłon społecznych wywołało protesty."
)
Event.create!(
  title: "Studenci żądają rozszerzenia programów stypendialnych",
  description: "Uniwersytety i organizacje studenckie domagają się zwiększenia budżetu na stypendia i programy socjalne.",
  frequency: 60,
  region: "Mazowieckie",
  budget_name: "Szkolnictwo wyższe i nauka",
  budget_change: 450,
  is_adding_to_budget: true,
  positive_description: "Zwiększone stypendia poprawiły sytuację studentów z niezamożnych rodzin.",
  negative_description: "Brak działań pogłębia nierówności wśród studentów."
)
Event.create!(
  title: "Redukcja środków na przetwórstwo przemysłowe",
  description: "Wobec niskiego wykorzystania dotacji rząd planuje ograniczyć wsparcie dla przemysłu.",
  frequency: 40,
  region: nil,
  budget_name: "Przetwórstwo przemysłowe",
  budget_change: 600,
  is_adding_to_budget: false,
  positive_description: "Środki przesunięto na bardziej efektywne sektory.",
  negative_description: "Brak wsparcia osłabił rozwój lokalnych firm przemysłowych."
)
Event.create!(
  title: "Zwiększenie liczby schronisk dla bezdomnych",
  description: "Organizacje społeczne apelują o rozszerzenie sieci schronisk i wsparcia dla osób bezdomnych.",
  frequency: 65,
  region: "Łódzkie",
  budget_name: "Pomoc społeczna",
  budget_change: 700,
  is_adding_to_budget: true,
  positive_description: "Nowe placówki poprawiły warunki życia wielu osób w kryzysie.",
  negative_description: "Brak działań pogłębia problem bezdomności w regionie."
)
Event.create!(
  title: "Propozycja cięć w budżecie sądów",
  description: "Ministerstwo sprawiedliwości rozważa ograniczenie budżetu dla sądów rejonowych i okręgowych.",
  frequency: 45,
  region: nil,
  budget_name: "Wymiar sprawiedliwości",
  budget_change: 800,
  is_adding_to_budget: false,
  positive_description: "Oszczędności wdrożono bez wpływu na sprawność sądów.",
  negative_description: "Cięcia spowodowały opóźnienia w postępowaniach sądowych."
)
Event.create!(
  title: "Samorządy apelują o dopłaty do gospodarki odpadami",
  description: "Coraz więcej gmin nie radzi sobie z kosztami utylizacji odpadów i prosi o dopłaty z budżetu centralnego.",
  frequency: 50,
  region: "Zachodniopomorskie",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 500,
  is_adding_to_budget: true,
  positive_description: "Dopłaty ustabilizowały system gospodarki odpadami.",
  negative_description: "Brak wsparcia prowadzi do podwyżek opłat dla mieszkańców."
)
Event.create!(
  title: "Ograniczenie świadczeń z funduszu alimentacyjnego",
  description: "Rząd rozważa zaostrzenie kryteriów dostępu do funduszu alimentacyjnego w ramach oszczędności.",
  frequency: 40,
  region: nil,
  budget_name: "Rodzina",
  budget_change: 1500,
  is_adding_to_budget: false,
  positive_description: "Udało się ograniczyć nadużycia bez szkody dla potrzebujących.",
  negative_description: "Ograniczenia dotknęły samotnych rodziców i dzieci."
)
Event.create!(
  title: "Plan zarybiania jezior i rzek",
  description: "Związek rybacki wnioskuje o wsparcie programu zarybiania i oczyszczania jezior.",
  frequency: 35,
  region: "Warmińsko-mazurskie",
  budget_name: "Rybołówstwo i rybactwo",
  budget_change: 120,
  is_adding_to_budget: true,
  positive_description: "Poprawiła się bioróżnorodność i jakość wód w regionie.",
  negative_description: "Brak działań wpłynął negatywnie na populację ryb i ekoturystykę."
)
Event.create!(
  title: "Racjonalizacja wydatków na Policję w bezpiecznych regionach",
  description: "Statystyki pokazują spadek przestępczości w regionach takich jak Podlasie – sugeruje się ograniczenie liczby etatów policyjnych.",
  frequency: 50,
  region: "Podlaskie",
  budget_name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa",
  budget_change: 900,
  is_adding_to_budget: false,
  positive_description: "Mimo zmniejszenia budżetu, służby działają sprawnie dzięki niższemu zapotrzebowaniu.",
  negative_description: "Redukcja sił policyjnych okazała się przedwczesna – wzrosła liczba wykroczeń."
)
Event.create!(
  title: "Program oszczędności w gospodarce wodnej",
  description: "Ministerstwo klimatu planuje ograniczyć dotacje na inwestycje w obszarach o niskim ryzyku suszy.",
  frequency: 45,
  region: "Kujawsko-pomorskie",
  budget_name: "Rybołówstwo i rybactwo",
  budget_change: 600,
  is_adding_to_budget: false,
  positive_description: "Środki przekierowano do bardziej potrzebujących sektorów.",
  negative_description: "Niespodziewana susza obnażyła braki w infrastrukturze retencyjnej."
)
Event.create!(
  title: "Zamknięcie nierentownych połączeń kolejowych",
  description: "PKP proponuje zamknięcie kilku połączeń o niskim obłożeniu w regionach wiejskich.",
  frequency: 50,
  region: "Lubuskie",
  budget_name: "Transport i łączność",
  budget_change: 1000,
  is_adding_to_budget: false,
  positive_description: "Oszczędności pozwoliły na rozwój bardziej popularnych tras.",
  negative_description: "Likwidacja połączeń pogłębiła wykluczenie transportowe niektórych gmin."
)
Event.create!(
  title: "Zmniejszenie dofinansowania leków refundowanych",
  description: "Ministerstwo zdrowia sugeruje ograniczenie liczby refundowanych preparatów, wskazując na nadużycia.",
  frequency: 55,
  region: nil,
  budget_name: "Ochrona zdrowia",
  budget_change: 1500,
  is_adding_to_budget: false,
  positive_description: "Oszczędności wprowadzone bez wpływu na leczenie najcięższych chorób.",
  negative_description: "Pacjenci muszą pokrywać więcej kosztów z własnej kieszeni."
)
Event.create!(
  title: "Reforma systemu opieki nad dziećmi",
  description: "Nowelizacja ustawy zmniejsza liczbę placówek publicznych na rzecz opieki rodzinnej.",
  frequency: 40,
  region: "Pomorskie",
  budget_name: "Rodzina",
  budget_change: 800,
  is_adding_to_budget: false,
  positive_description: "Opieka zastępcza okazała się skuteczniejsza i tańsza.",
  negative_description: "Zbyt szybkie zmiany doprowadziły do chaosu w systemie pieczy zastępczej."
)
Event.create!(
  title: "Redukcja kosztów reprezentacyjnych administracji",
  description: "Kancelaria Premiera ogłasza cięcia w kosztach konferencji, delegacji i promocji.",
  frequency: 65,
  region: nil,
  budget_name: "Administracja publiczna",
  budget_change: 350,
  is_adding_to_budget: false,
  positive_description: "Ograniczono wydatki bez wpływu na efektywność urzędów.",
  negative_description: "Obniżono też środki na promocję Polski za granicą – spadek widoczności międzynarodowej."
)
Event.create!(
  title: "Zmniejszenie liczby dotacji do teatrów publicznych",
  description: "Ministerstwo kultury proponuje ograniczenie wsparcia dla instytucji teatralnych w mniejszych miastach.",
  frequency: 45,
  region: "Świętokrzyskie",
  budget_name: "Kultura i ochrona dziedzictwa narodowego",
  budget_change: 400,
  is_adding_to_budget: false,
  positive_description: "Ograniczono dotacje, zachowując wsparcie dla kluczowych ośrodków.",
  negative_description: "Zamknięcie kilku teatrów regionalnych obniżyło dostęp do kultury."
)
Event.create!(
  title: "Zmniejszenie środków na promocję sportu wyczynowego",
  description: "Część posłów chce przesunąć środki z zawodowego sportu na szkolenie dzieci i młodzieży.",
  frequency: 50,
  region: nil,
  budget_name: "Kultura fizyczna",
  budget_change: 500,
  is_adding_to_budget: false,
  positive_description: "Więcej środków trafiło do lokalnych szkółek i klubów młodzieżowych.",
  negative_description: "Brak wsparcia dla sportu zawodowego osłabił wyniki reprezentacji."
)
Event.create!(
  title: "Cyfryzacja urzędów – mniej papieru, więcej e-usług",
  description: "Rządowy program digitalizacji urzędów pozwala na redukcję kosztów administracyjnych.",
  frequency: 60,
  region: nil,
  budget_name: "Administracja publiczna",
  budget_change: 500,
  is_adding_to_budget: false,
  positive_description: "Mniej kolejek i papierologii – obywatele chwalą e-usługi.",
  negative_description: "Problemy z wdrożeniem ePUAP 2.0 opóźniają oszczędności."
)
Event.create!(
  title: "Szybszy internet dla szkół wiejskich",
  description: "Ministerstwo edukacji inwestuje w poprawę łączności internetowej na terenach wiejskich.",
  frequency: 55,
  region: "Podkarpackie",
  budget_name: "Oświata i wychowanie",
  budget_change: 300,
  is_adding_to_budget: true,
  positive_description: "Lepszy dostęp do cyfrowych narzędzi poprawia wyniki uczniów.",
  negative_description: "Infrastruktura wdrażana z opóźnieniem – szkoły czekają."
)
Event.create!(
  title: "Starzenie się społeczeństwa – apel o zwiększenie środków na opiekę długoterminową",
  description: "Wzrost liczby seniorów powoduje presję na system opieki zdrowotnej i socjalnej.",
  frequency: 70,
  region: nil,
  budget_name: "Pomoc społeczna",
  budget_change: 1000,
  is_adding_to_budget: true,
  positive_description: "Więcej opiekunów i placówek poprawia jakość życia seniorów.",
  negative_description: "Brak działań grozi niewydolnością systemu opieki."
)
Event.create!(
  title: "Przesunięcie środków z wojska na obronę cyberprzestrzeni",
  description: "MON proponuje zmniejszenie nakładów na sprzęt konwencjonalny, zwiększając inwestycje w cyberbezpieczeństwo.",
  frequency: 50,
  region: nil,
  budget_name: "Obrona narodowa",
  budget_change: 100,
  is_adding_to_budget: false,
  positive_description: "Nowe jednostki cyberobrony zwiększają odporność państwa.",
  negative_description: "Zmniejszenie inwestycji w sprzęt tradycyjny wzbudza obawy o gotowość bojową."
)
Event.create!(
  title: "Zamiana dotacji na pożyczki w sektorze rolnym",
  description: "Ministerstwo rolnictwa proponuje nową politykę – wsparcie dla rolników w formie niskooprocentowanych pożyczek.",
  frequency: 45,
  region: "Lubelskie",
  budget_name: "Rolnictwo i łowiectwo",
  budget_change: 800,
  is_adding_to_budget: false,
  positive_description: "Większa efektywność systemu – środki wracają do budżetu.",
  negative_description: "Rolnicy obawiają się zadłużenia – spada zaufanie do rządu."
)
Event.create!(
  title: "Powszechny program szczepień przeciw grypie",
  description: "Resort zdrowia rusza z kampanią bezpłatnych szczepień dla seniorów i uczniów.",
  frequency: 50,
  region: nil,
  budget_name: "Ochrona zdrowia",
  budget_change: 700,
  is_adding_to_budget: true,
  positive_description: "Spadek zachorowań i odciążenie szpitali w sezonie jesienno-zimowym.",
  negative_description: "Problemy logistyczne i braki szczepionek wywołują chaos."
)
Event.create!(
  title: "Koniec dopłat do paliw kopalnych dla sektora transportu",
  description: "Rząd kończy kontrowersyjne subsydia dla diesla w transporcie towarowym.",
  frequency: 45,
  region: nil,
  budget_name: "Transport i łączność",
  budget_change: 1500,
  is_adding_to_budget: false,
  positive_description: "Zwiększyło się zainteresowanie transportem niskoemisyjnym.",
  negative_description: "Wzrost kosztów przewozów przekłada się na ceny towarów."
)
Event.create!(
  title: "Dotacje na instalacje fotowoltaiczne dla samorządów",
  description: "Fundusz klimatyczny ogłasza nowy program wsparcia dla gmin inwestujących w OZE.",
  frequency: 50,
  region: "Opolskie",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 900,
  is_adding_to_budget: true,
  positive_description: "Spadły koszty energii w urzędach i szkołach.",
  negative_description: "Niektóre gminy nie zdążyły wykorzystać środków – przepadły fundusze."
)
Event.create!(
  title: "Centralizacja niektórych instytucji – redukcja etatów w regionach",
  description: "Rząd konsoliduje wybrane instytucje publiczne, ograniczając zatrudnienie w oddziałach terenowych.",
  frequency: 45,
  region: nil,
  budget_name: "Administracja publiczna",
  budget_change: 1000,
  is_adding_to_budget: false,
  positive_description: "Zmniejszono koszty i usprawniono zarządzanie.",
  negative_description: "Zwolnienia wywołały niezadowolenie i protesty w regionach."
)
Event.create!(
  title: "Modernizacja oświetlenia ulicznego w Sieradzu",
  description: "Miasto Sieradz inwestuje w energooszczędne lampy LED, co pozwoli na obniżenie kosztów energii.",
  frequency: 60,
  region: "Łódzkie",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 250,
  is_adding_to_budget: true,
  positive_description: "Zmniejszyły się rachunki za prąd i poprawiło bezpieczeństwo na ulicach Sieradza.",
  negative_description: "Problemy z montażem opóźniły efekty inwestycji."
)
Event.create!(
  title: "Renowacja budynku sądu powiatowego w Ełku",
  description: "Niezbędne prace remontowe w sądzie powiatowym w Ełku poprawią komfort pracy i dostęp do wymiaru sprawiedliwości.",
  frequency: 50,
  region: "Warmińsko-mazurskie",
  budget_name: "Wymiar sprawiedliwości",
  budget_change: 300,
  is_adding_to_budget: true,
  positive_description: "Obywatelom łatwiej załatwić sprawy sądowe w nowoczesnym budynku sądu w Ełku.",
  negative_description: "Prace opóźniają rozpatrywanie spraw z powodu zamknięcia pomieszczeń."
)
Event.create!(
  title: "Cięcia w budżecie szkół ponadpodstawowych w Słupsku",
  description: "Brak wystarczających środków zmusza do ograniczenia wyposażenia i zajęć dodatkowych w szkołach Słupska.",
  frequency: 55,
  region: "Pomorskie",
  budget_name: "Oświata i wychowanie",
  budget_change: 400,
  is_adding_to_budget: false,
  positive_description: "Nauczyciele i uczniowie w Słupsku skutecznie dostosowali się do nowych warunków.",
  negative_description: "Spadła jakość kształcenia i zainteresowanie szkołami w mieście."
)
Event.create!(
  title: "Rozbudowa lokalnego centrum zdrowia w Kutnie",
  description: "Powiatowa placówka zdrowotna w Kutnie otrzymuje fundusze na zakup sprzętu i zwiększenie kadry medycznej.",
  frequency: 65,
  region: "Łódzkie",
  budget_name: "Ochrona zdrowia",
  budget_change: 450,
  is_adding_to_budget: true,
  positive_description: "Mieszkańcy Kutna zyskali lepszy dostęp do specjalistycznej opieki.",
  negative_description: "Niewystarczające środki nie pokrywają wszystkich potrzeb."
)
Event.create!(
  title: "Problemy z utrzymaniem miejskiego basenu w Wejherowie",
  description: "Rosnące koszty energii zmuszają do ograniczenia godzin otwarcia basenu w Wejherowie.",
  frequency: 50,
  region: "Pomorskie",
  budget_name: "Kultura fizyczna",
  budget_change: 200,
  is_adding_to_budget: false,
  positive_description: "Mieszkańcy Wejherowa korzystają z basenu w najbardziej intensywnych godzinach.",
  negative_description: "Mniej czasu na rekreację wpływa na spadek kondycji mieszkańców."
)
Event.create!(
  title: "Wsparcie dla remizy OSP w Tarnowie",
  description: "Ochotnicza Straż Pożarna w Tarnowie otrzymuje fundusze na zakup nowego sprzętu ratowniczego.",
  frequency: 70,
  region: "Małopolskie",
  budget_name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa",
  budget_change: 300,
  is_adding_to_budget: true,
  positive_description: "OSP w Tarnowie skuteczniej działa podczas akcji ratowniczych.",
  negative_description: "Braki w wyposażeniu mogą wpłynąć na bezpieczeństwo mieszkańców."
)
Event.create!(
  title: "Optymalizacja wydatków na transport publiczny w Kaliszu",
  description: "Zmniejszenie liczby kursów autobusów w Kaliszu w celu ograniczenia kosztów operacyjnych.",
  frequency: 60,
  region: "Wielkopolskie",
  budget_name: "Transport i łączność",
  budget_change: 250,
  is_adding_to_budget: false,
  positive_description: "Mimo cięć transport w Kaliszu pozostaje sprawny i punktualny.",
  negative_description: "Mieszkańcy skarżą się na mniejszą dostępność komunikacji."
)
Event.create!(
  title: "Nowe programy profilaktyki zdrowotnej w Siedlcach",
  description: "Rozszerzenie działań profilaktycznych w Siedlcach w zakresie przeciwdziałania alkoholizmowi i narkomanii.",
  frequency: 50,
  region: "Mazowieckie",
  budget_name: "Ochrona zdrowia",
  budget_change: 150,
  is_adding_to_budget: true,
  positive_description: "Poprawa świadomości zdrowotnej mieszkańców Siedlec.",
  negative_description: "Brak wystarczających funduszy ogranicza skalę działań."
)
Event.create!(
  title: "Zmniejszenie środków na dotacje dla organizacji sportowych w Ostrowcu Świętokrzyskim",
  description: "Ograniczenie wsparcia finansowego dla lokalnych klubów sportowych w Ostrowcu Świętokrzyskim.",
  frequency: 45,
  region: "Świętokrzyskie",
  budget_name: "Kultura fizyczna",
  budget_change: 100,
  is_adding_to_budget: false,
  positive_description: "Kluby sportowe dostosowały się do nowych warunków finansowych.",
  negative_description: "Mniej imprez sportowych i niższa aktywność mieszkańców."
)
Event.create!(
  title: "Rewitalizacja zabytkowego rynku w Będzinie",
  description: "Remont i odnowa przestrzeni miejskiej wokół rynku w Będzinie.",
  frequency: 55,
  region: "Śląskie",
  budget_name: "Kultura i ochrona dziedzictwa narodowego",
  budget_change: 400,
  is_adding_to_budget: true,
  positive_description: "Rynek w Będzinie stał się atrakcyjniejszy dla mieszkańców i turystów.",
  negative_description: "Prace remontowe zakłóciły ruch i handel w centrum miasta."
)
Event.create!(
  title: "Podniesienie wydatków na edukację w Chełmie",
  description: "Większe finansowanie szkół publicznych w Chełmie, w tym zakup nowego sprzętu multimedialnego.",
  frequency: 70,
  region: "Lubelskie",
  budget_name: "Oświata i wychowanie",
  budget_change: 350,
  is_adding_to_budget: true,
  positive_description: "Lepsze warunki nauki dla uczniów i nauczycieli w Chełmie.",
  negative_description: "Opóźnienia w dostawie sprzętu ograniczyły korzyści inwestycji."
)
Event.create!(
  title: "Zmniejszenie finansowania pomocy społecznej w Płocku",
  description: "Ograniczenie zasiłków i wsparcia dla osób w trudnej sytuacji życiowej w Płocku.",
  frequency: 40,
  region: "Mazowieckie",
  budget_name: "Pomoc społeczna",
  budget_change: 300,
  is_adding_to_budget: false,
  positive_description: "Zwiększenie kontroli nad pomocą społeczną poprawiło jej efektywność.",
  negative_description: "Niektórzy mieszkańcy odczuli pogorszenie warunków życia."
)
Event.create!(
  title: "Nowe dotacje dla rolników w Łomży",
  description: "Wsparcie finansowe dla lokalnych rolników w Łomży na modernizację gospodarstw.",
  frequency: 60,
  region: "Podlaskie",
  budget_name: "Rolnictwo i łowiectwo",
  budget_change: 280,
  is_adding_to_budget: true,
  positive_description: "Rolnicy w Łomży poprawili wydajność i jakość produkcji.",
  negative_description: "Braki w dostawie środków ograniczyły tempo modernizacji."
)
Event.create!(
  title: "Zamknięcie części ścieżek rowerowych w Nowym Targu",
  description: "Ograniczenie utrzymania ścieżek rowerowych w Nowym Targu z powodu cięć budżetowych.",
  frequency: 45,
  region: "Małopolskie",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 150,
  is_adding_to_budget: false,
  positive_description: "Mieszkańcy Nowego Targu korzystają z najważniejszych tras rowerowych.",
  negative_description: "Spadek bezpieczeństwa i komfortu jazdy na rowerze."
)
Event.create!(
  title: "Budowa nowej hali sportowej w Tomaszowie Lubelskim",
  description: "Inwestycja w infrastrukturę sportową w Tomaszowie Lubelskim zwiększa możliwości rekreacji.",
  frequency: 65,
  region: "Lubelskie",
  budget_name: "Kultura fizyczna",
  budget_change: 320,
  is_adding_to_budget: true,
  positive_description: "Mieszkańcy Tomaszowa Lubelskiego zyskali nowoczesne miejsce do aktywności fizycznej.",
  negative_description: "Wysokie koszty budowy spowolniły inne inwestycje miejskie."
)
Event.create!(
  title: "Rozbudowa linii kolejowej w Zgierzu",
  description: "Zwiększenie przepustowości i modernizacja torów w Zgierzu w ramach rozwoju transportu publicznego.",
  frequency: 60,
  region: "Łódzkie",
  budget_name: "Transport i łączność",
  budget_change: 500,
  is_adding_to_budget: true,
  positive_description: "Szybszy i bardziej punktualny dojazd do Łodzi i innych miast regionu.",
  negative_description: "Roboty torowe zakłócają kursowanie pociągów przez kilka miesięcy."
)
Event.create!(
  title: "Zamknięcie małego muzeum w Kościerzynie z powodu cięć",
  description: "Miasto Kościerzyna decyduje się zrezygnować z utrzymywania małego lokalnego muzeum.",
  frequency: 50,
  region: "Pomorskie",
  budget_name: "Kultura i ochrona dziedzictwa narodowego",
  budget_change: 180,
  is_adding_to_budget: false,
  positive_description: "Środki zostały przekierowane na bardziej potrzebne cele lokalne.",
  negative_description: "Mieszkańcy żałują utraty miejsca promującego lokalną historię."
)
Event.create!(
  title: "Program darmowych stypendiów mieszkaniowych w Lesznie",
  description: "Władze Leszna uruchamiają pilotażowy program zakwaterowania dla studentów z biedniejszych rodzin.",
  frequency: 70,
  region: "Wielkopolskie",
  budget_name: "Szkolnictwo wyższe i nauka",
  budget_change: 240,
  is_adding_to_budget: true,
  positive_description: "Więcej młodych ludzi z Leszna może pozwolić sobie na studia.",
  negative_description: "Zainteresowanie programem przewyższyło dostępne zasoby."
)
Event.create!(
  title: "Likwidacja nocnej izby przyjęć w szpitalu w Nysie",
  description: "W celu ograniczenia wydatków, nocna obsługa pacjentów w Nysie zostaje przeniesiona do większego miasta.",
  frequency: 40,
  region: "Opolskie",
  budget_name: "Ochrona zdrowia",
  budget_change: 300,
  is_adding_to_budget: false,
  positive_description: "Pacjenci z Nysy szybko zaadaptowali się do nowego systemu.",
  negative_description: "Opóźnienia w dostępie do pilnej pomocy medycznej."
)
Event.create!(
  title: "Nowa oczyszczalnia ścieków w Bielsku Podlaskim",
  description: "Budowa ekologicznej oczyszczalni ścieków wspierana ze środków unijnych.",
  frequency: 65,
  region: "Podlaskie",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 420,
  is_adding_to_budget: true,
  positive_description: "Poprawa jakości wody i środowiska w Bielsku Podlaskim.",
  negative_description: "Początkowe problemy z wydajnością oczyszczalni."
)
Event.create!(
  title: "Cięcia w utrzymaniu infrastruktury drogowej w Kraśniku",
  description: "Mniej środków na naprawy nawierzchni i konserwację dróg lokalnych w Kraśniku.",
  frequency: 55,
  region: "Lubelskie",
  budget_name: "Transport i łączność",
  budget_change: 200,
  is_adding_to_budget: false,
  positive_description: "Racjonalizacja wydatków ograniczyła niepotrzebne remonty.",
  negative_description: "Stan niektórych dróg w Kraśniku znacznie się pogorszył."
)
Event.create!(
  title: "Otwarcie centrum adopcyjnego w Przemyślu",
  description: "Nowa placówka wspiera adopcje i zapewnia pomoc psychologiczną w Przemyślu.",
  frequency: 60,
  region: "Podkarpackie",
  budget_name: "Rodzina",
  budget_change: 280,
  is_adding_to_budget: true,
  positive_description: "Dzieci szybciej trafiają do rodzin zastępczych i adopcyjnych.",
  negative_description: "Koszty utrzymania centrum są wyższe niż planowano."
)
Event.create!(
  title: "Redukcja liczby patroli w Radomsku",
  description: "Ze względu na niższy poziom przestępczości zmniejszono częstotliwość patroli policyjnych w Radomsku.",
  frequency: 50,
  region: "Łódzkie",
  budget_name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa",
  budget_change: 250,
  is_adding_to_budget: false,
  positive_description: "Pomimo oszczędności, poziom bezpieczeństwa w Radomsku się utrzymał.",
  negative_description: "Mieszkańcy zgłaszają obawy związane z mniejszą widocznością służb."
)
Event.create!(
  title: "Remont internatu w Starachowicach",
  description: "Poprawa warunków bytowych dla uczniów szkół zawodowych mieszkających w internacie.",
  frequency: 55,
  region: "Świętokrzyskie",
  budget_name: "Edukacyjna opieka wychowawcza",
  budget_change: 200,
  is_adding_to_budget: true,
  positive_description: "Lepsze warunki życia wpływają na wyniki nauki i samopoczucie młodzieży.",
  negative_description: "Nie wszystkie planowane prace udało się ukończyć na czas."
)
Event.create!(
  title: "Dotacje na zarybianie zbiorników w Żninie",
  description: "Lokalne władze w Żninie przeznaczają środki na poprawę fauny wodnej i turystyki wędkarskiej.",
  frequency: 45,
  region: "Kujawsko-pomorskie",
  budget_name: "Rybołówstwo i rybactwo",
  budget_change: 120,
  is_adding_to_budget: true,
  positive_description: "Zwiększono atrakcyjność Żnina dla miłośników wędkarstwa.",
  negative_description: "Efekty zarybiania będą widoczne dopiero za kilka sezonów."
)
Event.create!(
  title: "Rozbudowa miejskiego żłobka w Mińsku Mazowieckim",
  description: "Władze Mińska Mazowieckiego inwestują w zwiększenie liczby miejsc w żłobku publicznym.",
  frequency: 65,
  region: "Mazowieckie",
  budget_name: "Rodzina",
  budget_change: 220,
  is_adding_to_budget: true,
  positive_description: "Więcej rodzin skorzysta z opieki żłobkowej, ułatwiając powrót rodziców do pracy.",
  negative_description: "Nowe miejsca szybko się zapełniły, potrzeby nadal są duże."
)
Event.create!(
  title: "Likwidacja małego oddziału psychiatrii w Łowiczu",
  description: "Z powodu braku specjalistów i ograniczonego budżetu zamknięto oddział psychiatryczny w Łowiczu.",
  frequency: 45,
  region: "Łódzkie",
  budget_name: "Ochrona zdrowia",
  budget_change: 300,
  is_adding_to_budget: false,
  positive_description: "Pacjenci kierowani są do większych, lepiej wyposażonych placówek.",
  negative_description: "Lokalni pacjenci mają utrudniony dostęp do pomocy psychicznej."
)
Event.create!(
  title: "Utworzenie parku kieszonkowego w Wągrowcu",
  description: "Na zaniedbanym skwerze w centrum Wągrowca powstaje ekologiczny, mały park miejski.",
  frequency: 60,
  region: "Wielkopolskie",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 130,
  is_adding_to_budget: true,
  positive_description: "Nowe zielone miejsce sprzyja integracji i odpoczynkowi mieszkańców.",
  negative_description: "Koszty utrzymania parku mogą rosnąć w kolejnych latach."
)
Event.create!(
  title: "Redukcja etatów w straży miejskiej w Zamościu",
  description: "Władze Zamościa zdecydowały o zmniejszeniu liczby funkcjonariuszy straży miejskiej.",
  frequency: 55,
  region: "Lubelskie",
  budget_name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa",
  budget_change: 270,
  is_adding_to_budget: false,
  positive_description: "Oszczędności bez pogorszenia ogólnego poczucia bezpieczeństwa.",
  negative_description: "Mieszkańcy zgłaszają wzrost wykroczeń porządkowych."
)
Event.create!(
  title: "Nowe laboratorium chemiczne w szkołach średnich w Suwałkach",
  description: "W Suwałkach powstaje nowoczesna pracownia chemiczna do nauki eksperymentalnej w liceach.",
  frequency: 70,
  region: "Podlaskie",
  budget_name: "Oświata i wychowanie",
  budget_change: 260,
  is_adding_to_budget: true,
  positive_description: "Uczniowie z Suwałk mają dostęp do profesjonalnego sprzętu edukacyjnego.",
  negative_description: "Szkolenia kadry opóźniły pełne wykorzystanie możliwości pracowni."
)
Event.create!(
  title: "Zamrożenie środków na remonty świetlic wiejskich w Rypinie",
  description: "Z powodu trudnej sytuacji finansowej Rypin wstrzymuje dotacje na modernizację świetlic.",
  frequency: 50,
  region: "Kujawsko-pomorskie",
  budget_name: "Kultura i ochrona dziedzictwa narodowego",
  budget_change: 150,
  is_adding_to_budget: false,
  positive_description: "Najpilniejsze remonty zostały wykonane w poprzednich latach.",
  negative_description: "Wiejskie społeczności tracą miejsca spotkań i integracji."
)
Event.create!(
  title: "Modernizacja oświetlenia ulicznego w Jarosławiu",
  description: "Jarosław inwestuje w energooszczędne oświetlenie LED na głównych ulicach miasta.",
  frequency: 65,
  region: "Podkarpackie",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 300,
  is_adding_to_budget: true,
  positive_description: "Zwiększone bezpieczeństwo i niższe rachunki za energię.",
  negative_description: "Problemy z awaryjnością nowego systemu w pierwszych tygodniach."
)
Event.create!(
  title: "Zamknięcie filii biblioteki publicznej w Brzesku",
  description: "W ramach konsolidacji sieci placówek kulturalnych, Brzesko zamyka jedną z filii biblioteki.",
  frequency: 45,
  region: "Małopolskie",
  budget_name: "Kultura i ochrona dziedzictwa narodowego",
  budget_change: 120,
  is_adding_to_budget: false,
  positive_description: "Księgozbiór i personel zostały przeniesione do lepiej wyposażonej placówki.",
  negative_description: "Mieszkańcy osiedla muszą dojeżdżać do głównej biblioteki."
)
Event.create!(
  title: "Powstanie lokalnego centrum wolontariatu w Środzie Wielkopolskiej",
  description: "W Środzie Wielkopolskiej uruchomiono punkt wspierający działalność społeczną i charytatywną.",
  frequency: 55,
  region: "Wielkopolskie",
  budget_name: "Pomoc społeczna",
  budget_change: 160,
  is_adding_to_budget: true,
  positive_description: "Wzrost zaangażowania mieszkańców w działania na rzecz innych.",
  negative_description: "Trudności w pozyskaniu stałych koordynatorów i wolontariuszy."
)
Event.create!(
  title: "Likwidacja połączenia autobusowego Ostrzeszów – Wrocław",
  description: "Z przyczyn finansowych Ostrzeszów rezygnuje z dotowania połączenia dalekobieżnego.",
  frequency: 50,
  region: "Wielkopolskie",
  budget_name: "Transport i łączność",
  budget_change: 230,
  is_adding_to_budget: false,
  positive_description: "Środki przesunięto na lokalne linie o większym znaczeniu społecznym.",
  negative_description: "Mieszkańcy tracą wygodny dojazd do stolicy województwa."
)
Event.create!(
  title: "Zanieczyszczenie ujęcia wody pitnej w Ostrowi Mazowieckiej",
  description: "W wyniku skażenia chemicznego wody gruntowej, główne ujęcie wody w Ostrowi Mazowieckiej zostaje tymczasowo zamknięte.",
  frequency: 30,
  region: "Mazowieckie",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 450,
  is_adding_to_budget: true,
  positive_description: "Kryzys zażegnano szybko, a infrastruktura wodociągowa została zmodernizowana.",
  negative_description: "Przez kilka dni mieszkańcy nie mieli dostępu do bieżącej wody."
)
Event.create!(
  title: "Protesty przeciwko likwidacji szkoły rolniczej w Sokółce",
  description: "Decyzja o zamknięciu technikum rolniczego w Sokółce wywołuje protesty lokalnej społeczności.",
  frequency: 35,
  region: "Podlaskie",
  budget_name: "Oświata i wychowanie",
  budget_change: 190,
  is_adding_to_budget: false,
  positive_description: "Część uczniów została przeniesiona do lepiej wyposażonej szkoły w Białymstoku.",
  negative_description: "Społeczność lokalna traci ważną placówkę edukacyjną z tradycjami."
)
Event.create!(
  title: "Pożar hali przemysłowej w Lubartowie",
  description: "W wyniku zwarcia elektrycznego doszło do dużego pożaru w hali produkcyjnej w Lubartowie.",
  frequency: 25,
  region: "Lubelskie",
  budget_name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa",
  budget_change: 300,
  is_adding_to_budget: true,
  positive_description: "Szybka interwencja służb zapobiegła rozprzestrzenieniu się ognia.",
  negative_description: "Zniszczeniu uległ ważny zakład pracy, co spowodowało lokalny wzrost bezrobocia."
)
Event.create!(
  title: "Skandal wokół przetargu na inwestycję w Opatowie",
  description: "Media ujawniają nieprawidłowości w przyznaniu kontraktu na budowę hali sportowej w Opatowie.",
  frequency: 30,
  region: "Świętokrzyskie",
  budget_name: "Kultura fizyczna",
  budget_change: 150,
  is_adding_to_budget: false,
  positive_description: "Po kontroli procesy przetargowe w gminie zostały usprawnione.",
  negative_description: "Zaufanie mieszkańców do lokalnych władz zostało poważnie nadszarpnięte."
)
Event.create!(
  title: "Zatrucie rzeki Wełny w Obornikach",
  description: "Nielegalne zrzuty ścieków przemysłowych doprowadzają do masowego śnięcia ryb w Obornikach.",
  frequency: 30,
  region: "Wielkopolskie",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 380,
  is_adding_to_budget: true,
  positive_description: "Zidentyfikowano sprawców, a rzeka objęta została programem odbudowy.",
  negative_description: "Utracono sezon turystyczny związany z rekreacją nad wodą."
)
Event.create!(
  title: "Nielegalna spalarnia odpadów ujawniona w Łęczycy",
  description: "Śledztwo wykazuje, że na obrzeżach Łęczycy funkcjonowała nielegalna spalarnia odpadów przemysłowych.",
  frequency: 30,
  region: "Łódzkie",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 270,
  is_adding_to_budget: true,
  positive_description: "Sprawa zakończyła się zamknięciem obiektu i reformą lokalnych procedur inspekcji.",
  negative_description: "Mieszkańcy obawiają się długofalowych skutków zdrowotnych."
)
Event.create!(
  title: "Nagły exodus lekarzy ze szpitala powiatowego w Szczytnie",
  description: "Z powodu niskich wynagrodzeń kilku specjalistów wypowiada umowy i opuszcza szpital w Szczytnie.",
  frequency: 25,
  region: "Warmińsko-mazurskie",
  budget_name: "Ochrona zdrowia",
  budget_change: 310,
  is_adding_to_budget: true,
  positive_description: "Wprowadzono nowy system motywacyjny dla kadry medycznej.",
  negative_description: "Na kilka tygodni ograniczono działalność niektórych oddziałów."
)
Event.create!(
  title: "Fala kradzieży katalizatorów w Skierniewicach",
  description: "Lokalna policja w Skierniewicach odnotowuje gwałtowny wzrost kradzieży części samochodowych.",
  frequency: 40,
  region: "Łódzkie",
  budget_name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa",
  budget_change: 150,
  is_adding_to_budget: true,
  positive_description: "Zwiększona liczba patroli doprowadza do ujęcia sprawców.",
  negative_description: "Wzrost poczucia zagrożenia wśród mieszkańców przedłużył się o kilka tygodni."
)
Event.create!(
  title: "Zatrzymanie burmistrza w Radzyniu Podlaskim",
  description: "Centralne Biuro Antykorupcyjne zatrzymuje burmistrza Radzynia Podlaskiego w związku z podejrzeniami korupcyjnymi.",
  frequency: 20,
  region: "Lubelskie",
  budget_name: "Administracja publiczna",
  budget_change: 100,
  is_adding_to_budget: false,
  positive_description: "Nowe władze obiecują transparentność i konsultacje społeczne.",
  negative_description: "Lokalna administracja pogrąża się w chaosie decyzyjnym przez kilka miesięcy."
)
Event.create!(
  title: "Masowy wyjazd młodzieży z Hajnówki",
  description: "Brak lokalnych ofert pracy i uczelni wyższych powoduje migrację młodych ludzi z Hajnówki do większych miast.",
  frequency: 40,
  region: "Podlaskie",
  budget_name: "Pomoc społeczna",
  budget_change: 120,
  is_adding_to_budget: true,
  positive_description: "Gmina inwestuje w szkolenia i zachęty dla powracających specjalistów.",
  negative_description: "Starzenie się populacji wpływa negatywnie na lokalną gospodarkę i usługi publiczne."
)
Event.create!(
  title: "Program adaptacji senioralnej w Dębicy",
  description: "Władze Dębicy uruchamiają pilotażowy program przystosowania przestrzeni miejskiej do potrzeb seniorów.",
  frequency: 55,
  region: "Podkarpackie",
  budget_name: "Pomoc społeczna",
  budget_change: 250,
  is_adding_to_budget: true,
  positive_description: "Starsze osoby zyskują większą samodzielność i bezpieczeństwo w przestrzeni miejskiej.",
  negative_description: "Koszty utrzymania programu przewyższyły pierwotne założenia."
)
Event.create!(
  title: "Wdrożenie systemu inteligentnego monitoringu w Złotoryi",
  description: "Miasto Złotoryja uruchamia zaawansowany system kamer z analizą obrazu w czasie rzeczywistym.",
  frequency: 50,
  region: "Dolnośląskie",
  budget_name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa",
  budget_change: 310,
  is_adding_to_budget: true,
  positive_description: "Spadek drobnych przestępstw i aktów wandalizmu w centrum miasta.",
  negative_description: "Pojawiają się obawy mieszkańców dotyczące prywatności i nadzoru."
)
Event.create!(
  title: "Brak lekarzy rodzinnych w Hrubieszowie",
  description: "Starzenie się kadry medycznej i brak chętnych do pracy powoduje niedobory lekarzy pierwszego kontaktu w Hrubieszowie.",
  frequency: 40,
  region: "Lubelskie",
  budget_name: "Ochrona zdrowia",
  budget_change: 280,
  is_adding_to_budget: true,
  positive_description: "Wprowadzono system teleporad i pozyskano wsparcie z większych miast.",
  negative_description: "Pacjenci muszą czekać tygodniami na wizyty, co pogarsza stan zdrowia populacji."
)
Event.create!(
  title: "Susza ogranicza dostęp do wody w Końskich",
  description: "Długotrwały brak opadów wpływa na zasoby wodne gminy Końskie i zmusza do racjonowania wody.",
  frequency: 30,
  region: "Świętokrzyskie",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 350,
  is_adding_to_budget: true,
  positive_description: "Władze inwestują w programy retencji i edukację ekologiczną.",
  negative_description: "Rolnicy i mieszkańcy skarżą się na ograniczenia w użytkowaniu wody."
)
Event.create!(
  title: "Upowszechnienie zdalnej edukacji w Grajewie",
  description: "Szkoły w Grajewie przechodzą częściowo na edukację hybrydową z wykorzystaniem platform online.",
  frequency: 55,
  region: "Podlaskie",
  budget_name: "Oświata i wychowanie",
  budget_change: 200,
  is_adding_to_budget: true,
  positive_description: "Uczniowie zyskują dostęp do nowoczesnych materiałów i metod nauki.",
  negative_description: "Nie wszystkie rodziny mają odpowiedni sprzęt i warunki do nauki zdalnej."
)
Event.create!(
  title: "Masowy napływ migrantów z Ukrainy do Tomaszowa Lubelskiego",
  description: "Tomaszów Lubelski doświadcza wzrostu liczby uchodźców i migrantów z Ukrainy.",
  frequency: 40,
  region: "Lubelskie",
  budget_name: "Pomoc społeczna",
  budget_change: 420,
  is_adding_to_budget: true,
  positive_description: "Mieszkańcy i władze wspierają integrację i tworzą miejsca pracy dla nowych przybyszów.",
  negative_description: "System usług publicznych jest przeciążony i dochodzi do napięć społecznych."
)
Event.create!(
  title: "Remont zabytkowego ratusza w Zamościu",
  description: "Historyczny ratusz wymaga pilnego remontu – mieszkańcy apelują o środki.",
  positive_description: "Odnowiony ratusz przyciąga turystów i podnosi prestiż miasta.",
  negative_description: "Brak remontu grozi degradacją zabytku i spadkiem przychodów z turystyki.",
  budget_name: "Kultura i ochrona dziedzictwa narodowego",
  budget_change: 1000,
  is_adding_to_budget: true,
  frequency: 10
)
Event.create!(
  title: "Zamknięcie kopalni węgla w Bełchatowie",
  description: "Z powodu wyczerpania złoża przyspiesza się proces zamykania kopalni.",
  positive_description: "Program przekwalifikowania górników i zielone inwestycje w regionie.",
  negative_description: "Wzrost bezrobocia i protesty pracownicze.",
  budget_name: "Górnictwo i kopalnictwo",
  budget_change: 5000,
  is_adding_to_budget: false,
  frequency: 15
)
Event.create!(
  title: "Wzrost przestępczości w Świdnicy",
  description: "Zauważalny wzrost włamań i rozbojów – mieszkańcy oczekują reakcji.",
  positive_description: "Dodatkowe patrole i monitoring przywracają poczucie bezpieczeństwa.",
  negative_description: "Brak działań skutkuje dalszym spadkiem zaufania do władz.",
  budget_name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa",
  budget_change: 2000,
  is_adding_to_budget: true,
  frequency: 20
)
Event.create!(
  title: "Redukcja etatów policyjnych w Kołobrzegu",
  description: "Rozważane jest zmniejszenie liczby etatów w policji z powodu niskiej przestępczości.",
  positive_description: "Oszczędności budżetowe bez pogorszenia stanu bezpieczeństwa.",
  negative_description: "Zbyt duża redukcja wydłuża czas reakcji na zdarzenia.",
  budget_name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa",
  budget_change: 3000,
  is_adding_to_budget: false,
  frequency: 12
)
Event.create!(
  title: "Przebudowa skrzyżowań w Piotrkowie Trybunalskim",
  description: "Inwestycja ma zmniejszyć korki w centrum miasta.",
  positive_description: "Sprawniejszy ruch uliczny skraca czas dojazdów i obniża emisję spalin.",
  negative_description: "Długotrwałe prace utrudniają prowadzenie lokalnych biznesów.",
  budget_name: "Transport i łączność",
  budget_change: 2500,
  is_adding_to_budget: true,
  frequency: 18
)
Event.create!(
  title: "Rozbudowa szpitala wojewódzkiego w Białymstoku",
  description: "W Białymstoku konieczna jest rozbudowa szpitala wojewódzkiego w związku z rosnącą liczbą pacjentów i ograniczoną liczbą łóżek. Projekt obejmuje budowę nowego skrzydła oraz zakup nowoczesnego sprzętu diagnostycznego.",
  positive_description: "Wygląda na to, że w budżecie zarezerwowano odpowiednią kwotę dla rozbudowy szpitala.",
  negative_description: "Z powodu niewystarczających środków rozbudowa szpitala musi zostać wstrzymana.",
  budget_name: "Ochrona zdrowia",
  budget_change: 12000,
  frequency: 12,
  is_adding_to_budget: true,
  region: "Podlaskie"
)

Event.create!(
  title: "Katastrofa ekologiczna w dolinie Odry",
  description: "W wyniku wycieku toksycznych substancji do Odry na odcinku między Głogowem a Brzegiem Dolnym konieczne jest sfinansowanie akcji oczyszczającej oraz wprowadzenie monitoringu wód.",
  positive_description: "Akcja oczyszczająca przebiegła sprawnie.",
  negative_description: "Przyroda znów została pozostawiona sama sobie. Nie jest to dobrze odbierane przez okolicznych mieszkańców.",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 25000,
  frequency: 5,
  is_adding_to_budget: true,
  region: "Dolnośląskie"
)

Event.create!(
  title: "Remont jednostek OSP w powiecie Nowotarskim",
  description: "W kilku gminach powiatu nowotarskiego strażacy ochotnicy działają w warunkach zagrażających ich bezpieczeństwu. Konieczne są inwestycje w remizy i pojazdy.",
  positive_description: "Poczynione inwestycje cieszą członków OSP.",
  negative_description: "W wyniku zaniedbań finansowych druhowie odchodzą z OSP - mają dojść braku finansowania.",
  budget_name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa",
  budget_change: 3000,
  frequency: 20,
  is_adding_to_budget: true,
  region: "Małopolskie"
)

Event.create!(
  title: "Modernizacja linii kolejowej w Koninie",
  description: "Rząd planuje dofinansowanie rewitalizacji ważnej linii kolejowej w Koninie, usprawniającej transport między Poznaniem a Warszawą.",
  positive_description: "Linie kolejowe zostaną zrewitalizowane.",
  negative_description: "Brakuje funduszy w transporcie.",
  budget_name: "Transport i łączność",
  budget_change: 40000,
  frequency: 4,
  is_adding_to_budget: true,
  region: "Wielkopolskie"
)

Event.create!(
  title: "Utrzymanie parków krajobrazowych w Puszczy Noteckiej",
  description: "W regionie Puszczy Noteckiej potrzebne są środki na zatrudnienie nowych leśników i modernizację infrastruktury służącej ochronie przyrody.",
  positive_description: "Finansowanie parków zostało zabezpieczone.",
  negative_description: "Brak funduszy skutkował brakiem zatrudnienia nowych leśników.",
  budget_name: "Ogrody botaniczne i zoologiczne oraz naturalne obszary i obiekty chronionej przyrody",
  budget_change: 1500,
  frequency: 22,
  is_adding_to_budget: true,
  region: "Lubuskie"
)

Event.create!(
  title: "Budowa nowego internatu w Piotrkowie Trybunalskim",
  positive_description: "Plany budowy nowego internatu są już w przygotowaniu.",
  negative_description: "Uczniowie z okolic miasta nadal będą musieli dojeżdżać do miasta, gdyż zabrakło funduszy na budowę.",
  description: "Rosnąca liczba uczniów z okolicznych wsi dojeżdżających do Piotrkowa sprawiła, że dotychczasowy internat nie wystarcza. Potrzebne fundusze na budowę nowego budynku.",
  budget_name: "Edukacyjna opieka wychowawcza",
  budget_change: 2500,
  frequency: 18,
  is_adding_to_budget: true,
  region: "Łódzkie"
)

Event.create!(
  title: "Wzmocnienie patroli granicznych w powiecie bieszczadzkim",
  positive_description: "Ludzie dostrzegli większą aktywność Straży Granicznej, dzięki czemu czują się bezpieczniejsi.",
  negative_description: "Brak środków do zatrudnienia kolejnych strażników na pewno nie przypadnie mieszkańcom do gustu.",
  description: "W związku z rosnącą presją migracyjną w rejonie Bieszczad konieczne jest zwiększenie liczby patroli Straży Granicznej oraz zakup specjalistycznego sprzętu.",
  budget_name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa",
  budget_change: 8000,
  frequency: 10,
  is_adding_to_budget: true,
  region: "Podkarpackie"
)

Event.create!(
  title: "Wsparcie dla uczelni technicznej w Radomiu",
  positive_description: "Uczniowie cieszą się z zakupionego sprzętu.",
  negative_description: "Brak inwestycji w uczelnię nie podoba się stowarzyszeniu studentów.",
  description: "Rząd chce dofinansować rozwój kierunków technicznych w Radomiu — planowany zakup nowego sprzętu laboratoryjnego oraz podniesienie wynagrodzeń kadry naukowej.",
  budget_name: "Szkolnictwo wyższe i nauka",
  budget_change: 6000,
  frequency: 15,
  is_adding_to_budget: true,
  region: "Mazowieckie"
)

Event.create!(
  title: "Dotacje na rekultywację terenów pogórniczych w Wałbrzychu",
  positive_description: "Bezpieczeństwo mieszkańców na tych terenach zostanie zwiększone, są fundusze na renowację terenów pogórniczych.",
  negative_description: "Rząd nie znalazł finansowania, w Wałbrzuchu nadal część terenów pozostanie niezagospodarowana.",
  description: "Tereny pogórnicze w Wałbrzychu wymagają rekultywacji, zabezpieczenia hałd i przygotowania pod inwestycje prywatne i mieszkaniowe.",
  budget_name: "Górnictwo i kopalnictwo",
  budget_change: 20000,
  frequency: 7,
  is_adding_to_budget: true,
  region: "Dolnośląskie"
)

Event.create!(
  title: "Utworzenie centrum sportowego w Koszalinie",
  description: "Koszalin planuje budowę regionalnego centrum sportowego. Projekt obejmuje halę, boiska, a także programy wspierające młodzieżowe kluby sportowe.",
  positive_description: "Młodzież i mieszkańcy zyskają nowoczesne miejsce do aktywnego spędzania czasu i rozwoju sportowego.",
  negative_description: "Brak wsparcia dla budowy centrum spotkał się z niezadowoleniem lokalnych klubów sportowych i rodziców dzieci.",
  budget_name: "Kultura fizyczna",
  budget_change: 9000,
  frequency: 11,
  is_adding_to_budget: true,
  region: "Zachodniopomorskie"
)

Event.create!(
  title: "Budowa drogi obwodowej wokół Ostrołęki",
  description: "W związku z rosnącym natężeniem ruchu ciężarowego w Ostrołęce planowana jest budowa drogi obwodowej. Projekt ma na celu zmniejszenie korków i poprawę bezpieczeństwa mieszkańców.",
  positive_description: "Mieszkańcy Ostrołęki zauważają zmniejszenie hałasu i korków w centrum miasta.",
  negative_description: "Zaniechanie inwestycji spowoduje dalsze utrudnienia komunikacyjne i pogorszenie jakości życia w mieście.",
  budget_name: "Transport i łączność",
  budget_change: 45000,
  frequency: 4,
  is_adding_to_budget: true,
  region: "Mazowieckie"
)

Event.create!(
  title: "Nowe centrum diagnostyki onkologicznej w Elblągu",
  description: "W Elblągu rozpoczyna się budowa nowoczesnego centrum diagnostyki onkologicznej w ramach zwiększenia dostępności do badań przesiewowych i wczesnej diagnostyki nowotworowej.",
  positive_description: "Mieszkańcy regionu będą mieli szybszy dostęp do diagnostyki onkologicznej, co zwiększy szanse na skuteczne leczenie.",
  negative_description: "Brak inwestycji w centrum to zagrożenie dla pacjentów, którzy muszą podróżować wiele kilometrów w poszukiwaniu pomocy.",
  budget_name: "Ochrona zdrowia",
  budget_change: 28000,
  frequency: 6,
  is_adding_to_budget: true,
  region: "Warmińsko-mazurskie"
)

Event.create!(
  title: "Rozbudowa infrastruktury przedszkolnej w Zamościu",
  description: "Zamość otrzymuje środki na rozbudowę miejskich przedszkoli — planowane są nowe oddziały, modernizacja kuchni i zwiększenie dostępności dla dzieci z niepełnosprawnościami.",
  positive_description: "Rodzice zyskają więcej miejsc w przedszkolach, a dzieci będą miały lepsze warunki do nauki i zabawy.",
  negative_description: "Brak rozbudowy oznacza dalsze problemy z dostępnością miejsc i nierówne szanse edukacyjne dla najmłodszych.",
  budget_name: "Edukacyjna opieka wychowawcza",
  budget_change: 3500,
  frequency: 20,
  is_adding_to_budget: true,
  region: "Lubelskie"
)

Event.create!(
  title: "Wsparcie dla systemu kanalizacji w powiecie leszczyńskim",
  description: "Poważne niedobory infrastruktury wodno-kanalizacyjnej w powiecie leszczyńskim wymusiły przeznaczenie dodatkowych środków na budowę nowoczesnych oczyszczalni i sieci.",
  positive_description: "Mieszkańcy zyskają dostęp do nowoczesnej kanalizacji, co poprawi warunki sanitarne i jakość życia.",
  negative_description: "Brak środków na kanalizację grozi problemami zdrowotnymi i środowiskowymi.",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 15000,
  frequency: 10,
  is_adding_to_budget: true,
  region: "Wielkopolskie"
)

Event.create!(
  title: "Zakup nowoczesnych karetek dla powiatu puławskiego",
  description: "Szpital powiatowy w Puławach otrzyma dofinansowanie na zakup dwóch nowoczesnych karetek reanimacyjnych z pełnym wyposażeniem medycznym.",
  positive_description: "Nowe karetki skrócą czas reakcji i poprawią jakość ratownictwa medycznego w regionie.",
  negative_description: "Brak inwestycji w karetki to ryzyko opóźnień w udzielaniu pomocy i zagrożenie dla życia pacjentów.",
  budget_name: "Ochrona zdrowia",
  budget_change: 5000,
  frequency: 16,
  is_adding_to_budget: true,
  region: "Lubelskie"
)

Event.create!(
  title: "Dotacja na rozwój bibliotek cyfrowych w Tarnobrzegu",
  description: "Tarnobrzeska sieć bibliotek miejskich otrzymuje wsparcie na rozwój usług cyfrowych, zakup e-booków oraz szkolenia z obsługi nowoczesnych platform edukacyjnych.",
  positive_description: "Mieszkańcy Tarnobrzega zyskają dostęp do nowoczesnych zasobów edukacyjnych i kulturalnych bez wychodzenia z domu.",
  negative_description: "Zaniechanie inwestycji ograniczy rozwój cyfrowej edukacji i dostępność nowoczesnych źródeł wiedzy.",
  budget_name: "Kultura i ochrona dziedzictwa narodowego",
  budget_change: 2000,
  frequency: 22,
  is_adding_to_budget: true,
  region: "Podkarpackie"
)

Event.create!(
  title: "Usuwanie skutków suszy w rejonie Sieradza",
  description: "Z powodu długotrwałej suszy w sieradzkim konieczne jest dofinansowanie budowy zbiorników retencyjnych oraz zabezpieczenia ujęć wody pitnej.",
  positive_description: "Budowa zbiorników poprawi bezpieczeństwo wodne i pozwoli przetrwać kolejne okresy suszy bez strat w rolnictwie.",
  negative_description: "Brak działań to ryzyko niedoboru wody i poważnych strat gospodarczych dla rolników i mieszkańców.",
  budget_name: "Rolnictwo i łowiectwo",
  budget_change: 10000,
  frequency: 9,
  is_adding_to_budget: true,
  region: "Łódzkie"
)

Event.create!(
  title: "Modernizacja oświetlenia ulicznego w Nowym Targu",
  description: "W Nowym Targu planowana jest modernizacja oświetlenia ulicznego na energooszczędne LED-y, co ma zmniejszyć zużycie energii i poprawić bezpieczeństwo na drogach.",
  positive_description: "Oświetlenie LED przyczyni się do znacznych oszczędności energii i poprawi widoczność na ulicach, zwiększając bezpieczeństwo mieszkańców.",
  negative_description: "Koszty inwestycji mogą być wysokie, a prace mogą powodować tymczasowe utrudnienia komunikacyjne.",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 7000,
  frequency: 14,
  is_adding_to_budget: true,
  region: "Małopolskie"
)

Event.create!(
  title: "Rozwój turystyki rowerowej w regionie kujawsko-pomorskim",
  description: "Władze województwa kujawsko-pomorskiego inwestują w rozwój sieci tras rowerowych, aby przyciągnąć turystów i promować aktywny wypoczynek.",
  positive_description: "Lepsza infrastruktura rowerowa zwiększy atrakcyjność regionu oraz wpłynie pozytywnie na zdrowie mieszkańców.",
  negative_description: "Inwestycja wymaga dużych nakładów finansowych, a korzyści mogą być widoczne dopiero w dłuższym czasie.",
  budget_name: "Kultura fizyczna",
  budget_change: 12000,
  frequency: 9,
  is_adding_to_budget: true,
  region: "Kujawsko-pomorskie"
)

Event.create!(
  title: "Wsparcie dla szkół specjalnych w regionie podlaskim",
  description: "Podlaskie otrzymuje fundusze na wyposażenie i remonty szkół specjalnych oraz na szkolenia dla nauczycieli specjalistów.",
  positive_description: "Poprawa warunków w szkołach specjalnych zwiększy jakość edukacji i wsparcia dla dzieci z niepełnosprawnościami.",
  negative_description: "Środki mogą nie wystarczyć na pełne pokrycie wszystkich potrzeb, a proces inwestycyjny może się opóźnić.",
  budget_name: "Edukacyjna opieka wychowawcza",
  budget_change: 6000,
  frequency: 11,
  is_adding_to_budget: true,
  region: "Podlaskie"
)

Event.create!(
  title: "Budowa nowego przystanku kolejowego w powiecie piotrkowskim",
  description: "Powiat piotrkowski planuje budowę nowego przystanku kolejowego, który usprawni komunikację publiczną i przyczyni się do rozwoju gospodarczego.",
  positive_description: "Nowy przystanek zwiększy dostępność transportu i zachęci mieszkańców do korzystania z kolei.",
  negative_description: "Koszty inwestycji mogą przekroczyć założenia, a realizacja opóźnić się z powodu problemów technicznych.",
  budget_name: "Transport i łączność",
  budget_change: 22000,
  frequency: 5,
  is_adding_to_budget: true,
  region: "Łódzkie"
)

Event.create!(
  title: "Program dofinansowania opieki nad seniorami w województwie świętokrzyskim",
  description: "Województwo świętokrzyskie uruchamia program wsparcia opieki nad osobami starszymi, zwiększając dostęp do domów opieki oraz usług opiekuńczych.",
  positive_description: "Seniorzy zyskają lepszą opiekę i wsparcie, co poprawi ich komfort życia i zdrowie.",
  negative_description: "Program będzie wymagał stałego finansowania, które może obciążyć budżet województwa.",
  budget_name: "Pomoc społeczna",
  budget_change: 8000,
  frequency: 13,
  is_adding_to_budget: true,
  region: "Świętokrzyskie"
)

Event.create!(
  title: "Modernizacja systemu kanalizacji w mieście Ostrołęka",
  description: "Miasto Ostrołęka inwestuje w modernizację przestarzałego systemu kanalizacyjnego, by poprawić jakość środowiska i zapobiec awariom.",
  positive_description: "Nowoczesny system kanalizacyjny zmniejszy ryzyko zanieczyszczeń i poprawi warunki sanitarne.",
  negative_description: "Wysokie koszty inwestycji oraz prace mogą powodować utrudnienia dla mieszkańców.",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 18000,
  frequency: 8,
  is_adding_to_budget: true,
  region: "Mazowieckie"
)

Event.create!(
  title: "Wsparcie dla lokalnych artystów w województwie lubuskim",
  description: "Urząd marszałkowski uruchamia granty dla lokalnych artystów i organizacji kulturalnych, aby wspierać rozwój kultury i sztuki.",
  positive_description: "Wsparcie finansowe pomoże w realizacji nowych projektów artystycznych i ożywi lokalne życie kulturalne.",
  negative_description: "Środki mogą nie być wystarczające, aby objąć wszystkie zainteresowane podmioty.",
  budget_name: "Kultura i ochrona dziedzictwa narodowego",
  budget_change: 5000,
  frequency: 12,
  is_adding_to_budget: true,
  region: "Lubuskie"
)

Event.create!(
  title: "Rozbudowa infrastruktury sportowej w województwie podkarpackim",
  description: "Województwo podkarpackie inwestuje w modernizację i rozbudowę obiektów sportowych, by promować aktywność fizyczną wśród mieszkańców.",
  positive_description: "Lepsze obiekty sportowe zachęcą mieszkańców do regularnej aktywności i poprawią wyniki sportowe.",
  negative_description: "Inwestycja wiąże się z wysokimi kosztami i możliwymi opóźnieniami w realizacji.",
  budget_name: "Kultura fizyczna",
  budget_change: 15000,
  frequency: 7,
  is_adding_to_budget: true,
  region: "Podkarpackie"
)

Event.create!(
  title: "Inicjatywa ograniczenia zanieczyszczenia powietrza w województwie śląskim",
  description: "W ramach programu ekologicznego województwo śląskie uruchamia działania mające na celu zmniejszenie emisji zanieczyszczeń powietrza.",
  positive_description: "Poprawa jakości powietrza wpłynie korzystnie na zdrowie mieszkańców i środowisko naturalne.",
  negative_description: "Realizacja programu może wymagać znacznych środków finansowych oraz współpracy z przemysłem.",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 20000,
  frequency: 10,
  is_adding_to_budget: true,
  region: "Śląskie"
)

Event.create!(
  title: "Budowa nowoczesnego centrum zdrowia psychicznego w województwie lubelskim",
  description: "Województwo lubelskie inwestuje w stworzenie centrum zdrowia psychicznego, by poprawić dostęp do profesjonalnej pomocy psychologicznej.",
  positive_description: "Nowoczesne centrum poprawi jakość opieki i zwiększy dostępność specjalistów.",
  negative_description: "Inwestycja wymaga dużych nakładów i może być trudna do realizacji w krótkim czasie.",
  budget_name: "Ochrona zdrowia",
  budget_change: 25000,
  frequency: 4,
  is_adding_to_budget: true,
  region: "Lubelskie"
)

Event.create!(
  title: "Modernizacja biblioteki wojewódzkiej w województwie opolskim",
  description: "Opolskie planuje modernizację biblioteki wojewódzkiej, aby zwiększyć jej dostępność i funkcjonalność dla mieszkańców.",
  positive_description: "Nowoczesna biblioteka stanie się centrum edukacji i kultury dla regionu.",
  negative_description: "Koszty modernizacji mogą być wysokie, a prace mogą czasowo ograniczyć dostęp do usług.",
  budget_name: "Kultura i ochrona dziedzictwa narodowego",
  budget_change: 9000,
  frequency: 11,
  is_adding_to_budget: true,
  region: "Opolskie"
)

Event.create!(
  title: "Rozwój sieci wodociągowej w województwie zachodniopomorskim",
  description: "Zachodniopomorskie inwestuje w rozbudowę i modernizację sieci wodociągowej, aby poprawić dostęp do czystej wody dla mieszkańców.",
  positive_description: "Lepsza infrastruktura wodociągowa zapewni stały dostęp do wysokiej jakości wody pitnej.",
  negative_description: "Koszty modernizacji mogą być wysokie, a prace budowlane mogą powodować chwilowe utrudnienia.",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 14000,
  frequency: 9,
  is_adding_to_budget: true,
  region: "Zachodniopomorskie"
)

Event.create!(
  title: "Wsparcie dla edukacji cyfrowej w szkołach województwa łódzkiego",
  description: "Łódzkie przeznacza środki na wyposażenie szkół w nowoczesny sprzęt komputerowy oraz szkolenia dla nauczycieli z zakresu edukacji cyfrowej.",
  positive_description: "Zwiększenie kompetencji cyfrowych uczniów i nauczycieli podniesie jakość nauczania.",
  negative_description: "Inwestycje mogą być niewystarczające, aby objąć wszystkie placówki edukacyjne.",
  budget_name: "Oświata i wychowanie",
  budget_change: 11000,
  frequency: 8,
  is_adding_to_budget: true,
  region: "Łódzkie"
)

Event.create!(
  title: "Promocja lokalnych produktów rolnych w województwie podlaskim",
  description: "Podlaskie organizuje kampanię promocyjną wspierającą lokalnych rolników i producentów żywności.",
  positive_description: "Akcja pomoże zwiększyć sprzedaż lokalnych produktów i wesprze rolników.",
  negative_description: "Efekty kampanii mogą być ograniczone, jeśli nie zostanie odpowiednio sfinansowana.",
  budget_name: "Rolnictwo i łowiectwo",
  budget_change: 7000,
  frequency: 13,
  is_adding_to_budget: true,
  region: "Podlaskie"
)

Event.create!(
  title: "Budowa ścieżek edukacyjnych w województwie lubelskim",
  description: "Lubelskie realizuje projekt budowy ścieżek edukacyjnych w parkach narodowych i rezerwatach przyrody.",
  positive_description: "Ścieżki zwiększą świadomość ekologiczną i zachęcą do turystyki przyrodniczej.",
  negative_description: "Projekt może wymagać dużych nakładów oraz współpracy z wieloma instytucjami.",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 6000,
  frequency: 12,
  is_adding_to_budget: true,
  region: "Lubelskie"
)

Event.create!(
  title: "Modernizacja dróg lokalnych w województwie świętokrzyskim",
  description: "Świętokrzyskie inwestuje w remont i poprawę stanu dróg lokalnych, co poprawi komunikację i bezpieczeństwo ruchu.",
  positive_description: "Lepsze drogi ułatwią transport i wpłyną pozytywnie na rozwój regionu.",
  negative_description: "Prace mogą powodować czasowe utrudnienia i wymagają dużych nakładów finansowych.",
  budget_name: "Transport i łączność",
  budget_change: 19000,
  frequency: 6,
  is_adding_to_budget: true,
  region: "Świętokrzyskie"
)
Event.create!(
  title: "Wsparcie dla kultury ludowej w województwie podkarpackim",
  description: "Podkarpackie organizuje festiwale i warsztaty promujące tradycje ludowe oraz lokalne rękodzieło.",
  positive_description: "Wzrost zainteresowania kulturą regionalną i rozwój turystyki kulturalnej.",
  negative_description: "Koszty organizacji mogą przewyższyć efekty promocji.",
  budget_name: "Kultura i ochrona dziedzictwa narodowego",
  budget_change: 8000,
  frequency: 10,
  is_adding_to_budget: true,
  region: "Podkarpackie"
)

Event.create!(
  title: "Rozwój infrastruktury rowerowej w województwie wielkopolskim",
  description: "Wielkopolskie inwestuje w budowę ścieżek rowerowych i stojaków, by promować ekologiczny transport.",
  positive_description: "Poprawa jakości powietrza i zdrowia mieszkańców.",
  negative_description: "Inwestycja wymaga współpracy z samorządami i może mieć ograniczony zasięg.",
  budget_name: "Transport i łączność",
  budget_change: 13000,
  frequency: 11,
  is_adding_to_budget: true,
  region: "Wielkopolskie"
)

Event.create!(
  title: "Edukacja ekologiczna dla dzieci w województwie kujawsko-pomorskim",
  description: "Kujawsko-pomorskie realizuje program warsztatów i zajęć przyrodniczych dla najmłodszych.",
  positive_description: "Wzrost świadomości ekologicznej wśród młodego pokolenia.",
  negative_description: "Program może mieć ograniczony zasięg i wpływ w krótkim czasie.",
  budget_name: "Oświata i wychowanie",
  budget_change: 5000,
  frequency: 14,
  is_adding_to_budget: true,
  region: "Kujawsko-pomorskie"
)

Event.create!(
  title: "Wsparcie dla rozwoju turystyki zdrowotnej w województwie warmińsko-mazurskim",
  description: "Warmińsko-mazurskie inwestuje w infrastrukturę uzdrowiskową i promocję zdrowego stylu życia.",
  positive_description: "Zwiększenie liczby turystów i rozwój lokalnej gospodarki.",
  negative_description: "Inwestycje mogą wymagać długiego czasu zwrotu kosztów.",
  budget_name: "Turystyka",
  budget_change: 15000,
  frequency: 9,
  is_adding_to_budget: true,
  region: "Warmińsko-mazurskie"
)

Event.create!(
  title: "Modernizacja placówek opieki społecznej w województwie lubuskim",
  description: "Lubuskie przeznacza środki na remont i wyposażenie domów pomocy społecznej oraz ośrodków wsparcia.",
  positive_description: "Poprawa jakości usług dla osób potrzebujących wsparcia.",
  negative_description: "Wysokie koszty utrzymania mogą ograniczyć skalę modernizacji.",
  budget_name: "Pomoc społeczna",
  budget_change: 9000,
  frequency: 12,
  is_adding_to_budget: true,
  region: "Lubuskie"
)
Event.create!(
  title: "Budowa centrum sportowego w województwie opolskim",
  description: "Opolskie inwestuje w nowoczesne centrum sportowe z basenem, halą sportową i boiskami.",
  positive_description: "Poprawa warunków do uprawiania sportu dla mieszkańców i organizacja imprez sportowych.",
  negative_description: "Koszty budowy i utrzymania mogą być wysokie, a dostępność ograniczona.",
  budget_name: "Kultura fizyczna",
  budget_change: 20000,
  frequency: 8,
  is_adding_to_budget: true,
  region: "Opolskie"
)

Event.create!(
  title: "Rozbudowa sieci kanalizacyjnej w województwie pomorskim",
  description: "Pomorskie realizuje projekt rozbudowy kanalizacji w małych miejscowościach i wsiach.",
  positive_description: "Poprawa warunków sanitarnych i ochrona środowiska.",
  negative_description: "Koszty i trudności techniczne mogą opóźnić realizację.",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 15000,
  frequency: 9,
  is_adding_to_budget: true,
  region: "Pomorskie"
)

Event.create!(
  title: "Program wsparcia dla osób starszych w województwie mazowieckim",
  description: "Mazowieckie uruchamia programy aktywizacji społecznej i zdrowotnej dla seniorów.",
  positive_description: "Poprawa jakości życia i integracja osób starszych.",
  negative_description: "Programy mogą mieć ograniczony zasięg w dużym regionie.",
  budget_name: "Pomoc społeczna",
  budget_change: 12000,
  frequency: 11,
  is_adding_to_budget: true,
  region: "Mazowieckie"
)

Event.create!(
  title: "Inwestycje w energię odnawialną w województwie świętokrzyskim",
  description: "Świętokrzyskie stawia na rozwój farm wiatrowych i instalacji solarnych.",
  positive_description: "Zmniejszenie emisji CO2 i uniezależnienie od paliw kopalnych.",
  negative_description: "Wysokie koszty inwestycji i konieczność uzyskania pozwoleń.",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 16000,
  frequency: 10,
  is_adding_to_budget: true,
  region: "Świętokrzyskie"
)
Event.create!(
  title: "Rozwój cyfrowej edukacji w województwie lubelskim",
  description: "Lubelskie inwestuje w sprzęt komputerowy i szkolenia dla nauczycieli, aby zwiększyć dostęp do edukacji cyfrowej.",
  positive_description: "Podniesienie kompetencji cyfrowych uczniów i nauczycieli.",
  negative_description: "Wysokie koszty oraz konieczność stałego wsparcia technicznego.",
  budget_name: "Oświata i wychowanie",
  budget_change: 14000,
  frequency: 12,
  is_adding_to_budget: true,
  region: "Lubelskie"
)

Event.create!(
  title: "Modernizacja dróg lokalnych w województwie podlaskim",
  description: "Podlaskie prowadzi remonty i modernizacje lokalnych dróg, aby poprawić dostępność komunikacyjną.",
  positive_description: "Lepsza infrastruktura drogowa poprawia warunki życia mieszkańców i rozwój gospodarczy.",
  negative_description: "Duże nakłady finansowe mogą ograniczyć inne inwestycje.",
  budget_name: "Transport i łączność",
  budget_change: 17000,
  frequency: 10,
  is_adding_to_budget: true,
  region: "Podlaskie"
)

Event.create!(
  title: "Program rewitalizacji terenów poprzemysłowych w województwie dolnośląskim",
  description: "Dolnośląskie realizuje projekty rewitalizacji dawnych terenów przemysłowych na cele społeczne i rekreacyjne.",
  positive_description: "Ożywienie przestrzeni miejskich i wzrost atrakcyjności regionu.",
  negative_description: "Proces długi i kosztowny, wymaga współpracy różnych podmiotów.",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 22000,
  frequency: 9,
  is_adding_to_budget: true,
  region: "Dolnośląskie"
)

Event.create!(
  title: "Wsparcie dla inicjatyw kulturalnych w województwie zachodniopomorskim",
  description: "Zachodniopomorskie finansuje lokalne projekty artystyczne i kulturalne.",
  positive_description: "Rozwój lokalnej sceny kulturalnej i integracja społeczna.",
  negative_description: "Efekty programu mogą być trudne do zmierzenia i krótkotrwałe.",
  budget_name: "Kultura i ochrona dziedzictwa narodowego",
  budget_change: 8000,
  frequency: 13,
  is_adding_to_budget: true,
  region: "Zachodniopomorskie"
)

Event.create!(
  title: "Rozbudowa sieci wodociągowej w województwie łódzkim",
  description: "Łódzkie inwestuje w poprawę jakości i dostępności wody pitnej poprzez rozbudowę infrastruktury.",
  positive_description: "Poprawa zdrowia mieszkańców i warunków sanitarnych.",
  negative_description: "Wysokie koszty realizacji i utrzymania systemu.",
  budget_name: "Gospodarka komunalna i ochrona środowiska",
  budget_change: 16000,
  frequency: 11,
  is_adding_to_budget: true,
  region: "Łódzkie"
)
