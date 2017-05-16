class NewReview extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.state = {
      body: '',
      company_id: props.company_id,
      customer_id: props.customer_id,
      selectedStarArray: [],
      deselectedStarArray: [],
      starArray: [
        'glyphicon glyphicon-star-empty',
        'glyphicon glyphicon-star-empty',
        'glyphicon glyphicon-star-empty',
        'glyphicon glyphicon-star-empty',
        'glyphicon glyphicon-star-empty',
      ],
      maxStars: 5,
    }
  }

  render() {
    return(
      <div className="well">
        <div className="star-container">
          {this.state.starArray.map((star, index) => (
            <span key={index} onClick={() => this.handleClick(index)} className={star} aria-hidden='true'></span>
          ))}
        </div>
        <form onSubmit={this.handleSubmit}>
          <input onChange={this.handleChange} value={this.state.body} />
          <button>submit</button>
        </form>
      </div>
    )
  }

  handleClick(star_index) {
    let newStarArray = [];
    for (let i = 0; i < star_index + 1; i++) {
      newStarArray.push('glyphicon glyphicon-star');
    }
    for (let i = 0; i < (this.state.maxStars - star_index - 1); i++) {
      newStarArray.push('glyphicon glyphicon-star-empty');
    }
    this.setState({
      starArray: newStarArray,
    })
  }

  handleChange(e) {
    this.setState({body: e.target.value});
  }

  handleSubmit(e) {
    e.preventDefault();
    let newReview = {
      body: this.state.body,
    };

    let request = new Request('/api/v1/reviews', {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(this.state),
    });

    fetch(request).then((response) => {
      console.log(response)
      this.setState(() => ({
        body: newReview,
      }));
      console.log(this.state.body)
    })
  }
}
