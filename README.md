# flutter_notepad

- Для создания замектки воспользуйтесь кнопкой в правом нижнем углу

- Для удаления всех записей воспользуйтесь кнопкой с иконкой корзины на аппбаре

- Для загрузки фейковых записей из сети воспользуйтесь кнопкой с иконкой загрузки на аппбаре

- После изменений в di, нужно заново сгенерить код командой `flutter pub run build_runner build`. Может возникнуть ошибка из-за конфликтов, тогда нужно выполнить команду с флагом, который сначала удалит все старые файлы `flutter pub run build_runner build --delete-conflicting-outputs`