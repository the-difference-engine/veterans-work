class Review extends React.Component {

  constructor(props) {
    super(props)
    this.state = {
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
    }
  }

  componentWillMount() {
    let stars = this.state.selectedStars;
    for (let i = 0; i < stars + 1; i++) {
      this.state.selectedStarArray.push('_');
    }
    for (let i = 0; i < (this.state.maxStars - stars - 1); i++) {
      this.state.deselectedStarArray.push('_');
    }
  }

  render() {
    return(
      <div className="well">
        <div className="star-container">
          {this.state.selectedStarArray.map((testItem, index) => (
            <span key={index} onClick={() => this.handleClick(index)} className='glyphicon glyphicon-star' aria-hidden='true'></span>
          ))}
          {this.state.deselectedStarArray.map((testItem, index) => (
            <span key={index} onClick={() => this.handleClick(index)} className='glyphicon glyphicon-star-empty' aria-hidden='true'></span>
          ))}
        </div>
        <h3>{this.state.selectedStars} Stars</h3>
        <p onClick={this.handleClick}> "{this.state.body}" -{this.state.customer.email} </p>
        <p>{this.state.created_at}</p>
      </div>
    )
  }

  handleClick(starIndex) {
    console.log(starIndex)
    let selectedStarArray = this.state.selectedStarArray;
    let selectedStars = this.state.selectedStars;
    selectedStarArray = [];
    for (let i = 0; i < (starIndex + 1); i++ ) {
      selectedStarArray.push('_');
    }
    selectedStars = selectedStarArray.length;
    this.setState({
      selectedStarArray,
      selectedStars
    })
    console.log("clicked");
  }
}
