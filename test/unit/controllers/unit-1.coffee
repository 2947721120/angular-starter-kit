describe 'Controller: PasswordController', ->
  beforeEach module 'app.simple'

  $controller = undefined
  beforeEach inject((_$controller_) ->
    $controller = _$controller_
    return
  )
  describe '$scope.grade', ->
    $scope = undefined
    controller = undefined
    beforeEach ->
      $scope = {}
      controller = $controller('PasswordController', $scope: $scope)
      return
    it 'sets the strength to "strong" if the password length is >8 chars', ->
      $scope.password = 'longerthaneightchars'
      $scope.grade()
      expect($scope.strength).toEqual 'strong'
      return
    it 'sets the strength to "weak" if the password length <3 chars', ->
      $scope.password = 'a'
      $scope.grade()
      expect($scope.strength).toEqual 'weak'
      return
    return
  return
