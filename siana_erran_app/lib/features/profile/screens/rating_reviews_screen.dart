import 'package:flutter/material.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';

class RateAndReviewScreen extends StatefulWidget {
  const RateAndReviewScreen({super.key});

  @override
  State<RateAndReviewScreen> createState() => _RateAndReviewScreenState();
}

class _RateAndReviewScreenState extends State<RateAndReviewScreen> {
  // Sample data for reviews
  final List<ReviewData> reviews = [
    ReviewData(
      name: "Gao Pena",
      timeAgo: "2 hours ago",
      rating: 5,
      comment: "Excellent service, highly recommend!",
      avatar: "assets/images/avatar1.png",
    ),
    ReviewData(
      name: "Gao Pena",
      timeAgo: "1 day ago",
      rating: 5,
      comment: "Great experience and friendly staff.",
      avatar: "assets/images/avatar1.png",
    ),
    ReviewData(
      name: "Gao Pena",
      timeAgo: "5 days ago",
      rating: 5,
      comment: "Products are good but delivery was delayed.",
      avatar: "assets/images/avatar1.png",
    ),
    ReviewData(
      name: "Gao Pena",
      timeAgo: "1 week ago",
      rating: 5,
      comment: "Affordable pricing, will shop again.",
      avatar: "assets/images/avatar1.png",
    ),
    ReviewData(
      name: "Gao Pena",
      timeAgo: "2 weeks ago",
      rating: 5,
      comment: "Customer support resolved my issue quickly!",
      avatar: "assets/images/avatar1.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(
        title: "Ratings and Reviews", 
        addLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE5E7EB),
                  width: 1.0,
                ),
              ),
            ),
            child: const Text(
              "Ratings and Reviews",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          
          // Reviews List
          Expanded(
            child: Container(
              color: Colors.white,
              child: reviews.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      itemCount: reviews.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        color: Color(0xFFE5E7EB),
                        indent: 80,
                      ),
                      itemBuilder: (context, index) {
                        return _buildReviewItem(reviews[index]);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(ReviewData review) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                review.avatar,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE5E7EB),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Review Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Time Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    _buildStarRating(review.rating),
                  ],
                ),
                
                const SizedBox(height: 2),
                
                // Time ago
                Text(
                  review.timeAgo,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Comment
                Text(
                  review.comment,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF374151),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: 16,
          color: index < rating 
              ? const Color(0xFFFACC15) // Yellow color for filled stars
              : const Color(0xFFE5E7EB), // Gray color for empty stars
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.rate_review_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              "No Reviews Yet",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Be the first to leave a review!",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Data model for reviews
class ReviewData {
  final String name;
  final String timeAgo;
  final int rating;
  final String comment;
  final String avatar;

  ReviewData({
    required this.name,
    required this.timeAgo,
    required this.rating,
    required this.comment,
    required this.avatar,
  });
}

// Optional: Extension for more dynamic time formatting
extension TimeAgoExtension on DateTime {
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} week${(difference.inDays / 7).floor() == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}