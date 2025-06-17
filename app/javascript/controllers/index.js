import { application } from "./application"
import PresenceController from "./presence_controller"
import ReloadController from "./reload_controller"
import NavbarController from "./navbar_controller"
import ChatScrollController from "./chat_scroll_controller"
import ChatFormController from "./chat_form_controller"

application.register("presence", PresenceController)
application.register("reload", ReloadController)
application.register("navbar", NavbarController)
application.register("chat_form", ChatFormController)
application.register("chat_scroll", ChatScrollController)
