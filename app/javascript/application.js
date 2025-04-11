// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// 引入cocoon用于嵌套表单
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("@nathanvda/cocoon")
// 现有内容保留

// 添加 jQuery 和 Cocoon 支持
//= require jquery
//= require jquery_ujs
//= require cocoon