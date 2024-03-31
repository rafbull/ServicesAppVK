## Приложение отображающее информацию о сервисах **"ServicesAppVK"**

- Приложение написано на **UIKit** без использования `Storyboard`
- Архитектура **MVVM** с использованием паттерна **Coordinator** и с применением **Combine**
- По нажатию на какой-либо из сервисов откроется или его сайт, или приложение, если оно установлено. Для этого в `Info` таргета добавлен `URL Types`.
- Реализовано **кеширование** иконок сервисов в `UITableView`. 
- В случае **отстутствия интернета**, пользователь увидит соответствующее сообщение на экране.


---

#### Использованный стек:

- UIKit
- Auto Layout
- MVVM
- Coordinator
- Combine
- DiffableDataSource
- Min iOS - 15.0

---

## Скриншоты

### Основной интерфейс


| <img src="https://github.com/rafbull/ServicesAppVK/assets/148709354/b52173ca-501e-464a-ba88-3a70deacfbc8" width="400"> | <img src="https://github.com/rafbull/ServicesAppVK/assets/148709354/f517555c-e000-4e66-9120-bec0d5f82ce7" width="400"> | <img src="https://github.com/rafbull/ServicesAppVK/assets/148709354/f385cc7f-8efc-4025-ab43-c8be4f818f1b" width="400">
| --- | --- | --- |

---

### Открытие сервиса по `URL` и "pull to refresh"


| <img src="https://github.com/rafbull/ServicesAppVK/assets/148709354/956d5488-86cf-4d46-b946-4c444c0e412a" width="250"> | <img src="https://github.com/rafbull/ServicesAppVK/assets/148709354/f56991fb-d3a2-4d09-a09e-0d477e6a5156" width="300"> |
| --- | --- |
