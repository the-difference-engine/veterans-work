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
/******/ 	return __webpack_require__(__webpack_require__.s = 187);
/******/ })
/************************************************************************/
/******/ ({

/***/ 187:
/***/ (function(module, exports) {

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var Review = function (_React$Component) {
  _inherits(Review, _React$Component);

  function Review(props) {
    _classCallCheck(this, Review);

    var _this = _possibleConstructorReturn(this, (Review.__proto__ || Object.getPrototypeOf(Review)).call(this, props));

    _this.state = {
      id: props.review.id,
      body: props.review.body,
      companyId: props.review.company_id,
      customer: props.customer,
      selectedStars: props.review.stars,
      maxStars: 5,
      createdAt: props.review.created_at,
      updatedAt: props.review.updated_at,
      selectedStarArray: [],
      deselectedStarArray: []
    };
    return _this;
  }

  _createClass(Review, [{
    key: 'componentWillMount',
    value: function componentWillMount() {
      var stars = this.state.selectedStars;
      for (var i = 0; i < stars + 1; i++) {
        this.state.selectedStarArray.push('_');
      }
      for (var _i = 0; _i < this.state.maxStars - stars - 1; _i++) {
        this.state.deselectedStarArray.push('_');
      }
    }
  }, {
    key: 'render',
    value: function render() {
      var _this2 = this;

      return React.createElement(
        'div',
        { className: 'well' },
        React.createElement(
          'div',
          { className: 'star-container' },
          this.state.selectedStarArray.map(function (testItem, index) {
            return React.createElement('span', { key: index, onClick: function onClick() {
                return _this2.handleClick(index);
              }, className: 'glyphicon glyphicon-star', 'aria-hidden': 'true' });
          }),
          this.state.deselectedStarArray.map(function (testItem, index) {
            return React.createElement('span', { key: index, onClick: function onClick() {
                return _this2.handleClick(index);
              }, className: 'glyphicon glyphicon-star-empty', 'aria-hidden': 'true' });
          })
        ),
        React.createElement(
          'h3',
          null,
          this.state.selectedStars,
          ' Stars'
        ),
        React.createElement(
          'p',
          { onClick: this.handleClick },
          ' "',
          this.state.body,
          '" -',
          this.state.customer.email,
          ' '
        ),
        React.createElement(
          'p',
          null,
          this.state.created_at
        )
      );
    }
  }, {
    key: 'handleClick',
    value: function handleClick(starIndex) {
      console.log(starIndex);
      var selectedStarArray = this.state.selectedStarArray;
      var selectedStars = this.state.selectedStars;
      selectedStarArray = [];
      for (var i = 0; i < starIndex + 1; i++) {
        selectedStarArray.push('_');
      }
      selectedStars = selectedStarArray.length;
      this.setState({
        selectedStarArray: selectedStarArray,
        selectedStars: selectedStars
      });
      console.log("clicked");
    }
  }]);

  return Review;
}(React.Component);

/***/ })

/******/ });