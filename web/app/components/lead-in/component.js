import Ember from 'ember';
import $ from 'jquery';

export default Ember.Component.extend({
  attr: {},

  showPushDown: function () {
    $('.push-down').removeClass('hidden')
                    .css({height: this.attr.height,
                          top: this.attr.height});
  },

  scrollDown: function () {
    var $this = this;
    $.scrollTo(this.attr.height, 3000, {
      onAfter: function () {
        $this.sendAction();
      }
    });
  },

  actions: {
    startGame: function () {
      this.attr.height = $(window).height();
      this.showPushDown();
      this.scrollDown();
    }
  }
});
