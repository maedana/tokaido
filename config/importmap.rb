# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin 'hotkeys-js', to: 'https://ga.jspm.io/npm:hotkeys-js@3.9.1/dist/hotkeys.esm.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
