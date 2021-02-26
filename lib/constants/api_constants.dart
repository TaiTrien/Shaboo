const kPrefixUrl = 'http://api.youridea.studio';
const kPrefixUploadImageUrl = 'http://upload.youridea.studio/';

const successCodes = [200, 201, 202, 204];
const order = ['ASC', 'DESC', 'rating.finalScore', 'rating.ratingCount'];
enum EOrder {
  ASC,
  DESC,
  FinalScore,
  RatingCount,
}
