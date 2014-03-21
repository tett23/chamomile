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

