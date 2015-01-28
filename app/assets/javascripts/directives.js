var directives = angular.module('App.directives', [])

directives.directive('ngFocus', [function() {
  var FOCUS_CLASS = "ng-focused";
  return {
    restrict: 'A',
    require: 'ngModel',
    link: function(scope, element, attrs, ctrl) {
      ctrl.$focused = false;
      element.bind('focus', function(evt) {
        element.addClass(FOCUS_CLASS);
        scope.$apply(function() {ctrl.$focused = true;});
      }).bind('blur', function(evt) {
        element.removeClass(FOCUS_CLASS);
        scope.$apply(function() {ctrl.$focused = false;});
      });
    }
  }
}]);

directives.directive('setReviewRequestId', [function() {
    return {
      scope : {
          reviewRequestId : '@reviewRequestId',
      },
      controller: function($scope, $element, $attrs){
          $scope.reviewRequestId = $attrs.reviewRequestId
      }
    }
}]);

directives.directive('setOfferId', [function() {
    return {
      scope : {
          offerId : '@offerId',
      },
      controller: function($scope, $element, $attrs){
          $scope.offerId = $attrs.offerId
      }
    }
}]);
