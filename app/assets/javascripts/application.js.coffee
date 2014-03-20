#=require 'jquery'
#=require 'bootstrap'
#=require 'bootstrap/modal'
#=require 'vue/dist/vue'
#=require_tree .

class Templates
  @get: (name) ->
    defer = $.Deferred()
    $.get('/api/templates/'+name+'.html').done (r) ->
      defer.resolve(r)

    defer
  @load: (arr) ->
    defer = $.Deferred()
    templates = for name in arr
      Templates.get(name)
    $.when.apply($, templates).done () ->
      defer.resolve(arguments)

    defer
$ ->
  Templates.load(['recent', 'recent']).done (r) ->
    [recent, _] = r
    app = new Vue({
      el: '#main',
      partials: {
        recent: recent
      },
      data: {
      },
      methods: {
        data: {
          recent: ->
            self = @
            jQuery.getJSON('/api/pages/recent.json').done (r) ->
              self.$data.recentItems = r
        }
      }
    })
    app.$options.methods.data.recent.apply(app, null)

