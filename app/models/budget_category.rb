class BudgetCategory < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  default_scope { order(name: :asc) }

  def self.get(name:)
    seed if self.count == 0
    BudgetCategory.find_by(name: name)
  end

  def self.seed
    BudgetCategory.find_or_create_by!(start_budget: 11_091_653, name: "Rolnictwo i łowiectwo", description: "Melioracje wodne, prace geodezyjne dla rolnictwa, organizacja konkursów i wystaw zwierząt hodowlanych, dotacje dla rolników za wyłączenie z produkcji gruntów rolnych.")
    BudgetCategory.find_or_create_by!(start_budget: 141_839, name: "Rybołówstwo i rybactwo", description: "Usuwanie skutków klęsk żywiołowych zagrażających wodnej faunie i florze, utrzymanie czystości zbiorników wodnych, zarybianie.")
    BudgetCategory.find_or_create_by!(start_budget: 3_670_317, name: "Górnictwo i kopalnictwo", description: "Wsparcie dla sektora górniczego, w tym dotacje i subwencje dla przedsiębiorstw górniczych oraz wydatki związanych z restrukturyzacją tego sektora. Obejmują również finansowanie likwidacji kopalń, rekultywacji terenów pogórniczych oraz koszty przekwalifikowania pracowników górnictwa")
    BudgetCategory.find_or_create_by!(start_budget: 2_071_172, name: "Przetwórstwo przemysłowe", description: "Rozwój przedsiębiorczości w zakresie przemysłu, realizacja programów unijnych dot. gospodarki przemysłowej.")
    BudgetCategory.find_or_create_by!(start_budget: 24_786_780, name: "Transport i łączność", description: "Budowa i utrzymanie dróg krajowych. Również finansowanie przewozów kolejowych i autobusowych, budowa i utrzymanie mostów, lotnisk.")
    BudgetCategory.find_or_create_by!(start_budget: 118_109, name: "Turystyka", description: "Finansowanie zadań z zakresu upowszechniania turystyki i promocji kraju. Dotacje dla organizacji pozarządowych promujących turystykę w Polsce, w kraju i za granicą.")
    BudgetCategory.find_or_create_by!(start_budget: 30_032_922, name: "Administracja publiczna", description: "Wydatki dla pracowników urzędów państwowych, zakup materiałów i wyposażenia do urzędów, utrzymanie samochodów służbowych, remonty urzędów.")
    BudgetCategory.find_or_create_by!(start_budget: 109_583_160, name: "Obrona narodowa", description: "Koszty związane z utrzymaniem i funkcjonowaniem wojska, w tym uposażenia żołnierzy, a także koszty związane z udziałem w misjach zagranicznych i działaniami na rzecz bezpieczeństwa państwa, zakup sprzętu wojskowego, utrzymania infrastruktury wojskowej.")
    BudgetCategory.find_or_create_by!(start_budget: 31_434_956, name: "Bezpieczeństwo publiczne i ochrona przeciwpożarowa", description: "Wydatki na pensje, szkolenia, zakup sprzętu, utrzymanie remiz i pojazdów strażackich, Dotacje i dofinansowania dla OSP, Pokrycie kosztów operacji ratowniczych, usuwania skutków pożarów, powodzi, innych klęsk żywiołowych, Finansowanie zadań policji, straży granicznej, innych służb dbających o bezpieczeństwo obywateli.")
    BudgetCategory.find_or_create_by!(start_budget: 27_412_628, name: "Wymiar sprawiedliwości", description: "Wydatki dotyczące funkcjonowania sądów, prokuratur i innych instytucji związanych z systemem prawnym. Obejmują one koszty utrzymania budynków, wynagrodzenia pracowników (sędziów, prokuratorów, urzędników), wydatki na zakup usług, sprzętu i uzbrojenia.")
    BudgetCategory.find_or_create_by!(start_budget: 4_351_286, name: "Oświata i wychowanie", description: "Wynagrodzenia nauczycieli szkół publicznych, wyposażenie szkół, materiały dydaktyczne, koszty dokształcania nauczycieli, utrzymania bibliotek pedagogicznych.")
    BudgetCategory.find_or_create_by!(start_budget: 287_116, name: "Szkolnictwo wyższe i nauka", description: "Stypendia i zasiłki dla studentów, wyposażenie szkół, materiały dydaktyczne, wynagrodzenie wykładowców.")
    BudgetCategory.find_or_create_by!(start_budget: 40_503_110, name: "Ochrona zdrowia", description: "Zakup leków i środków biobójczych, programy zdrowotne, np. In Vitro, wydatki inwestycyjne szpitali klinicznych i szpitali ogólnych, budowa szpitali, ich remonty, wynagrodzenia pracowników, koszty programów profilaktyki zdrowotnej, w tym przeciwdziałanie alkoholizmowi i narkomanii.")
    BudgetCategory.find_or_create_by!(start_budget: 5_971_709, name: "Pomoc społeczna", description: "Zasiłki dla osób w trudnej sytuacji życiowej, wynagrodzenia dla pracowników systemu pomocy społecznej, przeciwdziałanie przemocy w rodzinie.")
    BudgetCategory.find_or_create_by!(start_budget: 299_136, name: "Edukacyjna opieka wychowawcza", description: "Internaty i bursy szkolne, w tym stypendia dla ich wychowanków.")
    BudgetCategory.find_or_create_by!(start_budget: 97_191_947, name: "Rodzina", description: "Działalność ośrodków adopcyjnych, świadczenia rodzinne, świadczenia z funduszu alimentacyjnego.")
    BudgetCategory.find_or_create_by!(start_budget: 2_584_033, name: "Gospodarka komunalna i ochrona środowiska", description: "Ochrona powietrza i klimatu, utrzymanie zieleni w miastach i gminach, gospodarowanie odpadami, zmniejszanie hałasu i wibracji.")
    BudgetCategory.find_or_create_by!(start_budget: 5_671_481, name: "Kultura i ochrona dziedzictwa narodowego", description: "Teatry, filharmonie, orkiestry, chóry i kapele, domy i ośrodki kultury, biblioteki, muzea, kluby, świetlice, dotacje dla organizacji pozarządowych zajmujących się kulturą, ochrona zabytków i opieka nad zabytkami.")
    BudgetCategory.find_or_create_by!(start_budget: 231_352, name: "Ogrody botaniczne i zoologiczne oraz naturalne obszary i obiekty chronionej przyrody", description: "Utrzymanie parków krajobrazowych, wynagrodzenie dla pracowników parków, utrzymanie ogrodów botanicznych.")
    BudgetCategory.find_or_create_by!(start_budget: 1_605_186, name: "Kultura fizyczna", description: "Utrzymanie obiektów sportowych, dotacje dla sportowych organizacji pozarządowych.")
  end
end
