class ReviewList extends React.Component {

  componentDidMount() {
    console.log('mounted')
    console.log(this.props.reviews)
  }

  render() {
    return(
      <ul>
        {this.props.reviews.map(review => (
          <p key={review.id}>{review.body}</p>
        ))}
      </ul>
    )
  }
}
