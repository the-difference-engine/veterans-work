/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs-test/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 186);
/******/ })
/************************************************************************/
/******/ ({

/***/ 186:
/***/ (function(module, exports) {

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var NewReview = function (_React$Component) {
  _inherits(NewReview, _React$Component);

  function NewReview(props) {
    _classCallCheck(this, NewReview);

    var _this = _possibleConstructorReturn(this, (NewReview.__proto__ || Object.getPrototypeOf(NewReview)).call(this, props));

    _this.handleChange = _this.handleChange.bind(_this);
    _this.handleSubmit = _this.handleSubmit.bind(_this);
    _this.state = {
      body: '',
      company_id: props.company_id,
      customer_id: props.customer_id,
      selectedStarArray: [],
      deselectedStarArray: [],
      starArray: ['glyphicon glyphicon-star-empty', 'glyphicon glyphicon-star-empty', 'glyphicon glyphicon-star-empty', 'glyphicon glyphicon-star-empty', 'glyphicon glyphicon-star-empty'],
      maxStars: 5
    };
    return _this;
  }

  _createClass(NewReview, [{
    key: 'render',
    value: function render() {
      var _this2 = this;

      return React.createElement(
        'div',
        { className: 'well' },
        React.createElement(
          'div',
          { className: 'star-container' },
          this.state.starArray.map(function (star, index) {
            return React.createElement('span', { key: index, onClick: function onClick() {
                return _this2.handleClick(index);
              }, className: star, 'aria-hidden': 'true' });
          })
        ),
        React.createElement(
          'form',
          { onSubmit: this.handleSubmit },
          React.createElement('input', { onChange: this.handleChange, value: this.state.body }),
          React.createElement(
            'button',
            null,
            'submit'
          )
        )
      );
    }
  }, {
    key: 'handleClick',
    value: function handleClick(star_index) {
      var newStarArray = [];
      for (var i = 0; i < star_index + 1; i++) {
        newStarArray.push('glyphicon glyphicon-star');
      }
      for (var _i = 0; _i < this.state.maxStars - star_index - 1; _i++) {
        newStarArray.push('glyphicon glyphicon-star-empty');
      }
      this.setState({
        starArray: newStarArray
      });
    }
  }, {
    key: 'handleChange',
    value: function handleChange(e) {
      this.setState({ body: e.target.value });
    }
  }, {
    key: 'handleSubmit',
    value: function handleSubmit(e) {
      var _this3 = this;

      e.preventDefault();
      var newReview = {
        body: this.state.body
      };

      var request = new Request('/api/v1/reviews', {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(this.state)
      });

      fetch(request).then(function (response) {
        console.log(response);
        _this3.setState(function () {
          return {
            body: newReview
          };
        });
        console.log(_this3.state.body);
      });
    }
  }]);

  return NewReview;
}(React.Component);

/***/ })

/******/ });