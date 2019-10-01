<br/>

## TodoApp

- Realm database kullandim
- Linting icin Swiftlint kullandim.
- `pod install` :)

#### Functionality

- Sag ust kosedeki arti butonu ile yeni item eklenebilir.
- Sola kaydirarak mevcut item silinebilir.
- Item'a dokunarak done/undone state'leri degistirilebilir.

#### Architecture

- Sadeligi korumak ve complexity'i arttirmamak amaciyla MVP (model-view-presenter) mimarisini tercih ettim.

#### Testing

- Tum yapilari testable tutabilmek icin manual dependency injection prensibini uyguladim.
- Ancak zamanim kisitli oldugu icin ornek olmasi acisindan sadece `Presenter` sinifi icin gerekli olan mock'lari yaratip, tum method'lari icin unit-test'lerini yazdim.

#### Improvement Points

- Item sorting
- Error handling, ornegin bos text ile item olusturma durumu icin.
- Presenter disindaki diger yapilarin unit-testleri, integration testler vs.
