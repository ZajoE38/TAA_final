# Hodnotenie

### Celkovo

---
- Replikovatelnost testu: 0:5    (PASS:FAIL)
  - **keyword**: `Assert Cart Count`
  - **chyba**: Setting list value to scalar variable '${item_count}' is not supported anymore. Create list variable '@{item_count}' instead.
  - **mozne riesenie**:  `Get Length` ma ocividne problem rozpoznat co chces od neho priamo. Toto vracia dlzku stringu/listu a ${items_in_cart} mas setnute ako string(xpath)
    - treba sa hlbsie pozriet do logiky aku chces dosiahnut
---
  
- Z pohladu testingu:
  - vadi mi ta abstrakcia, z pohladu nezaujateho cloveka netusim co by sa tam malo diat pod poklickou
  - z pohladu cloveka, ktory videl 'manualny' test case je to asi tiez dost tazke na 'namapovanie' co je co
  - zaroven aj ked sa hlbsie preklikam do logu, zacnem sa stracat

- Z pohladu automatizacie:
  - dobra folder structure, je to na prvy pohlad jasne co kde je
  - tie testy, az na problem vyssie napisany funguju
  - z pohladu cloveka co videl kod, mi je jasne co sa tam deje
  - plus na moj vkus je tam strasne setovani variables
    - je to take neprehladne
    - pride mi to ako by nebolo uplne jasne, co sa snazim dosiahnut

### Keywords subor

- Vyborne pouzitie `Set Window Size` kvoli nastavaniu rozlisenia
  
- Keyword: `Click On *`  (darceky, pre par, vianoce ...)
  - rychle pozretie heureka cz mi ukazalo, ze aj ked si nepouzil text, tak ine jazykove mutacie maju ine url
  - doporucil by som preto pouzit priamo to co vidis na screene, tj  lokalizovany text
  - a nasledne z tych  `Click On` keywordov, spravit 1 genericky:
    - `Click On    Tipy na darčeky` (analogicky pre ostatne 'Click On' keywordy)

- Keyword: `Choose Price Range`
  - z pohladu kw dobre
  - z pohladu testu, nejasne na aky price range sa klika
    - zase, volil by som argument, ktory by bol aky range chcem zvolit
  
- Keyword: `Click On Category`:
  - zase to co vyssie... byt exaktnejsi

- Keyword: `Buy 3 Items`:
  - keyword pekne navrhnuty
  - avsak dal by sa vylepsit do takeho stavu, aby bol pocet parametrizovany
  - potom by z toho bol pekny prepouzitelny kw
  - mozno by som este uvazoval o tom, ze su to 'random' items, tak by som to dal aj do nazvu:
    - `Buy ${variable} Random Items`
      - s tym, ze teda potom by som randomizoval iba ten index a ne cely xpath
  
- Keyword: `Assert Price Range`
  - riadky 73 a 74 mozu byt spojene:
    - `Should Be True    39 < ${item} < 101`
  - naming by som zmenil na: `Assert All Items Price Range`
    - kedze neuvadzas,  ktoru konkretnu validujes, ale validujes komplet kosik
  
- Keyword: `Assert Removal Of 1 Item`/`Remove 1 Item from Cart`:
  - tu sme troska nespecificky
  - volil by som nieco v zmysle:
    - `Remove Item From Cart    ${item_name}`  aby bolo jasne s ktorym pracujem
      - analogicky pre assert

### Variables subor

- ak pouzivas rovnake xpathy a menis len poslednu cast, reusni ich:
  - eg. riadky 11, 12 13
  
  ```
  ${item_general}    xpath:(//ul[contains(@class, "c-product-list__items")]/li)
  ${item4}    ${item_general}[4]
  ```


### Test Cases subor

- abstrakcia je priliz velka
  - nie je na pohlad jasne, co sa tam vlastne deje
    - konkretne s akymi itemami pracujem
      - ci su random, konkretne
      - ak su random z pohladu testu, treba tie keywordy upravit do stavu aby to bolo jasne
      - ak nie su random, treba keywordy upravit do stavu aby to bolo citatelne
    
- Keywordy s nazvom `Assert .*`:
  - nazvoslovie moze byt lubovolne
  - avsak bavili sme sa, ze robot framework pouziva `Should Be`/`Should Not Be`
    - takze validacne keywordy by mohli sledovat tuto konvenciu


### Readme.txt subor

- jasny, strucny, zrozumitelny


### requirements.txt subor

- zbytocny requirement `robotframework-pabot` kedze ho nepouzivame
  - nieje to chyba, iba zbytocna dependency, ktora sa nainstaluje aj ked ju netreba

### Git repository

- tu nevidim problem, dodane vsetko co ma byt
- nic navyse v repository nieje

   