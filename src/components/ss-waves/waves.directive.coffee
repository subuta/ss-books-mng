# Angularjs Directive Of Waves
# from: https://github.com/fians/Waves

app = angular.module "kaizenBooksMng"
app.directive 'ssWaves', (Waves) ->
  restrict: 'A'
  controllerAs: 'vm'
  require: '?ngClick'
  scope: {
    ssWaves: '@'
  }
  compile: (elem, attrs) ->
    # 通常は暗めの波
    wavesClass = []
    # 'light'は明るめの波
    if attrs.ssWaves is 'light'
      wavesClass = ['waves-light']
    # 'block'となっている場合は、ブロック要素向けのクラスを指定する。
    if attrs.ssWaves is 'block'
      wavesClass = ['waves-light', 'waves-block']
    Waves.attach(elem, wavesClass)

  controller: class
    constructor: (Waves) ->
      vm = @
      Waves.init({
        duration: 750,
        delay: 0
      })

      return vm
