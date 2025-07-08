import { application } from "./application"
import PresenceController from "./presence_controller"
import ReloadController from "./reload_controller"
import NavbarController from "./navbar_controller"
import ChatScrollController from "./chat_scroll_controller"
import ChatFormController from "./chat_form_controller"
import DropdownController from "./dropdown_controller"
import MessageController from "./message_controller"
import FullscreenController from "./fullscreen_controller"
import ConfirmController from "./confirm_controller"
import MapController from "./map_controller"
import ToggleSectionController from "./toggle_section_controller"
import SliderController from "./slider_controller"
import AvatarPreviewController from "./avatar_preview_controller"

application.register("presence", PresenceController)
application.register("reload", ReloadController)
application.register("navbar", NavbarController)
application.register("chat-form", ChatFormController)
application.register("chat-scroll", ChatScrollController)
application.register("dropdown", DropdownController)
application.register("message", MessageController)
application.register("fullscreen", FullscreenController)
application.register("confirm", ConfirmController)
application.register("map", MapController)
application.register("toggle-section", ToggleSectionController)
application.register("slider", SliderController)
application.register("avatar-preview", AvatarPreviewController)
