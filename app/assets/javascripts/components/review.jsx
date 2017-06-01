class Review extends React.Component {

  constructor(props) {
    super(props)
    this.state = {
      id: props.review.id,
      body: props.review.body,
      company_id: props.review.body,
      customer: props.customer,
      stars: props.review.stars,
      created_at: props.review.created_at,
      updated_at: props.review.updated_at,
    }
  }

  componentDidMount() {
    console.log('review mounted')
  }

  render() {
    return(
      <div>
        <h3>{this.state.stars} stars</h3>
        <p>"{this.state.body}" -{this.state.customer.email}</p>
        <p>{this.state.created_at}</p>
      </div>
    )
  }
}
