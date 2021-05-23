const kPrefixUrl = 'http://Quocs-MacBook-Pro.local:3000';
const kPrefixUploadImageUrl = 'http://Quocs-MacBook-Pro.local:3000/upload/';

// const kPrefixUrl = 'http://103.142.25.184:3000';
// const kPrefixUploadImageUrl = 'http://103.142.25.184:5000/upload/';

const successCodes = [200, 201, 202, 204];
const order = ['ASC', 'DESC', 'rating.finalScore', 'rating.ratingCount'];
enum EOrder {
  ASC,
  DESC,
  FinalScore,
  RatingCount,
}
