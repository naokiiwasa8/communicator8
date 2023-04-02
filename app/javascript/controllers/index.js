// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import TagifyController from "./tagify_controller"
application.register("tagify", TagifyController)

import ToastController from "./toast_controller"
application.register("toast", ToastController)

import TypingActionController from "./typing_action_controller"
application.register("typing-action", TypingActionController)