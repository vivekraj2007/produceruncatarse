App.addChild('Counter', {
  el: ".counter",

  onIncrement: function(event){
    this.select(event.digit)
  },

  initialize: function(){
    function lpad(str, padString, length) {
      while (str.length < length)
        str = padString + str;
      return str;
    }

    // Start by creating the digits
    this.$el.addClass('flip-clock-wrapper');
    this.max = this.$el.data('max');
    this.initial = this.$el.data('initial');
    this.rate = this.$el.data('rate');
    this.current = this.initial;

    var that = this;
    var currentDigits = lpad(this.current.toString(), "0", this.max.toString().length);

    _.each(this.max.toString(), function(digit, index){
      that.$el.append(that.createDigit(currentDigits[index]));
    });

    this.digits = this.$('ul.flip');
    this.digits.addClass("play");

    this.on('increment', this.onIncrement);
    this.setTimer();
  },

  setTimer: function(){
    var that = this;
    window.setInterval(function(){ that.incrementCounter() }, 1000);
  },

  incrementCounter: function(){
    var old = this.current;
    this.current += this.rate;
    var delta = parseInt(this.current) - parseInt(old);
    this.incrementDigit((this.digits.length - 1), delta);
  },

  incrementDigit: function(digitIndex, delta){
    if(digitIndex < 0){
      console.log('out of digits');
    }
    if(delta == 0){
      return;
    }
    var digit = $(this.digits[digitIndex]);
    digit.data('value', ((digit.data('value') + 1) % 10));
    this.trigger('increment', {digit: digit});
    if(digit.data('value') == 0){
      this.incrementDigit(digitIndex - 1, 1);
    }
    this.incrementDigit(digitIndex, delta - 1);
  },

  select: function($obj) {
    var digit = $obj.data('value');
    if(typeof digit === "undefined") {
      digit = 0;
    }

    var target = $obj.find('[data-digit="'+digit+'"]');
    var active = $obj.find('.flip-clock-active').removeClass("flip-clock-active");
    var before = $obj.find('.flip-clock-before').removeClass("flip-clock-before");

    if(target.is(':first-child')) {
      $obj.find(':last-child').addClass("flip-clock-before");
    }
    else {
      target.prev().addClass("flip-clock-before");
    }
    target.addClass("flip-clock-active");
  },

  createDigit: function(value){
    var html = $('<ul data-value="' + value + '" class="flip" />');

    for(var x = 0; x < 10; x++) {
      var item = $([
                   '<li data-digit="'+x+'">',
                   '<a href="#">',
                   '<div class="up">',
                   '<div class="shadow"></div>',
                   '<div class="inn">'+x+'</div>',
                   '</div>',
                   '<div class="down">',
                   '<div class="shadow"></div>',
                   '<div class="inn">'+x+'</div>',
                   '</div>',
                   '</a>',
                   '</li>'
      ].join(''));
      html.append(item);
    }
    return html;
  }
});

