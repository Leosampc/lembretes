# Lembretes

**App de cadastro de lembretes com notificações locais via push.**

### Descrição

O app foi desenvolvido a fins de estudos relacionado a linguagem _Swift_.

É um aplicativo de lembretes bem simples, onde você pode cadastrar lembretes, definindo um título, descrição (se quiser) e selecionando a data do lembrete através do `UIDatePicker`.

Os lembretes também podem ser excluídos, basta pressionar e segurar em cima do lembrete que deseja excluir e será exibida a opção "Excluir". Clicando em excluir, é exibido um alerta questionando se você realmente deseja excluir o lembrete com as opções "Cancelar" e "Excluir". Caso a opcão Excluir seja selecionada, o lembrete é excluído.

Uma observação é que ao abrir o App pela primeira vez é exibido um alerta perguntando se você permite com que o aplicativo envie notificações, isso acontece porque caso você opte por receber as notificações, ao cadastrar um lembrete o App agenda uma notificação baseada na data que foi selecionada. Em caso do lembrete ser excluído antes do envio da notificação, a mesma não é enviada pois o agendamento é excluído.

#### Alguns dos assuntos relevantes abordados no projeto:

- `FileManager`
- `NSKeyedArchiver` && `NSKeyedUnarchiver`
- `UILongPressGestureRecognizer`
- `UIMenuController` && `UIMenuItem`
- `UserNotifications`
- `DateComponents` && `DateFormatter`
