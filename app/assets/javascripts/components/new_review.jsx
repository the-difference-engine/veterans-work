class NewReview extends React.Component {
  constructor(props) {
    super(props);
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
        <input type="text" className="form-control" placeholder="leave review here..."></input>
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
}
