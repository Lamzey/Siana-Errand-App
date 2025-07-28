import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'errand_model.g.dart';

@JsonSerializable()
class ErrandModel {
  final String id;
  final String title;
  final String description;
  final ErrandStatus status;
  final AgentModel agent;
  final LocationModel pickupLocation;
  final LocationModel destination;
  final TimeModel timeDetails;
  final PaymentModel payment;
  final List<double> mapCoordinates; // [lat, lng]
  final String? notes;
  final DateTime createdAt;
  final DateTime? completedAt;

  ErrandModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.agent,
    required this.pickupLocation,
    required this.destination,
    required this.timeDetails,
    required this.payment,
    required this.mapCoordinates,
    this.notes,
    required this.createdAt,
    this.completedAt,
  }) {
    assert(mapCoordinates.length == 2, 'mapCoordinates must have exactly two elements');
    assert(status == ErrandStatus.completed || completedAt == null, 'completedAt should only be set when status is completed');
  }

  factory ErrandModel.fromJson(Map<String, dynamic> json) => _$ErrandModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrandModelToJson(this);

  ErrandModel copyWith({
    String? id,
    String? title,
    String? description,
    ErrandStatus? status,
    AgentModel? agent,
    LocationModel? pickupLocation,
    LocationModel? destination,
    TimeModel? timeDetails,
    PaymentModel? payment,
    List<double>? mapCoordinates,
    String? notes,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return ErrandModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      agent: agent ?? this.agent,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destination: destination ?? this.destination,
      timeDetails: timeDetails ?? this.timeDetails,
      payment: payment ?? this.payment,
      mapCoordinates: mapCoordinates ?? this.mapCoordinates,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

@JsonSerializable()
class AgentModel {
  final String id;
  final String name;
  final String profileImage;
  final double rating;
  final int totalRatings;
  final String agentCode;
  final VehicleModel vehicle;
  final String phoneNumber;
  final bool isOnline;

  AgentModel({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.rating,
    required this.totalRatings,
    required this.agentCode,
    required this.vehicle,
    required this.phoneNumber,
    required this.isOnline,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) => _$AgentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AgentModelToJson(this);

  String get displayName => name.length > 15 ? '${name.substring(0, 15)}...' : name;
  String get ratingText => '$rating Rating';
}

@JsonSerializable()
class VehicleModel {
  final String make;
  final String model;
  final String color;
  final String plateNumber;
  final String type;

  VehicleModel({
    required this.make,
    required this.model,
    required this.color,
    required this.plateNumber,
    required this.type,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => _$VehicleModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);

  String get displayName => '$make $model';
  String get fullDescription => '$color $make $model ($plateNumber)';
}

@JsonSerializable()
class LocationModel {
  final String address;
  final String name;
  final double latitude;
  final double longitude;
  final String? additionalInfo;
  final LocationType type;

  LocationModel({
    required this.address,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.additionalInfo,
    required this.type,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  String get displayAddress => name.isNotEmpty ? '$name, $address' : address;
}

@JsonSerializable()
class TimeModel {
  final DateTime scheduledTime;
  final DateTime? actualStartTime;
  final DateTime? actualEndTime;
  final int estimatedDurationMinutes;
  final String timeZone;

  TimeModel({
    required this.scheduledTime,
    this.actualStartTime,
    this.actualEndTime,
    required this.estimatedDurationMinutes,
    required this.timeZone,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) => _$TimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeModelToJson(this);

  String get formattedScheduledTime {
    final formatter = DateFormat('h:mm a', 'en_US');
    return formatter.format(scheduledTime.toLocal());
  }

  String get durationText {
    if (estimatedDurationMinutes < 60) {
      return '$estimatedDurationMinutes Min';
    } else {
      final hours = estimatedDurationMinutes ~/ 60;
      final minutes = estimatedDurationMinutes % 60;
      if (minutes == 0) {
        return '$hours Hour${hours > 1 ? 's' : ''}';
      }
      return '$hours Hour${hours > 1 ? 's' : ''} $minutes Min';
    }
  }

  String get actualDuration {
    if (actualStartTime != null && actualEndTime != null) {
      final duration = actualEndTime!.difference(actualStartTime!);
      return '${duration.inMinutes} Min';
    }
    return 'N/A';
  }
}

@JsonSerializable()
class PaymentModel {
  final double amount;
  final String currency;
  final PaymentMethod paymentMethod;
  final String? cardLast4;
  final PaymentStatus paymentStatus;
  final DateTime? paidAt;
  final String? transactionId;

  PaymentModel({
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    this.cardLast4,
    required this.paymentStatus,
    this.paidAt,
    this.transactionId,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);

  String get formattedAmount {
    final currencySymbols = {
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
    };
    final symbol = currencySymbols[currency] ?? currency;
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  String get paymentMethodDisplay {
    switch (paymentMethod) {
      case PaymentMethod.debitCard:
        return cardLast4 != null ? 'Debit Card ****$cardLast4' : 'Debit Card';
      case PaymentMethod.creditCard:
        return cardLast4 != null ? 'Credit Card ****$cardLast4' : 'Credit Card';
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.wallet:
        return 'Digital Wallet';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      default:
        return 'Unknown Payment Method';
    }
  }
}

enum ErrandStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('assigned')
  assigned,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('pickup_complete')
  pickupComplete,
  @JsonValue('in_transit')
  inTransit,
  @JsonValue('delivered')
  delivered,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

enum LocationType {
  @JsonValue('home')
  home,
  @JsonValue('office')
  office,
  @JsonValue('business')
  business,
  @JsonValue('other')
  other,
}

enum PaymentMethod {
  @JsonValue('debit_card')
  debitCard,
  @JsonValue('credit_card')
  creditCard,
  @JsonValue('cash')
  cash,
  @JsonValue('wallet')
  wallet,
  @JsonValue('bank_transfer')
  bankTransfer,
}

enum PaymentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('refunded')
  refunded,
}

extension ErrandStatusExtension on ErrandStatus {
  String get displayName {
    switch (this) {
      case ErrandStatus.pending:
        return 'Pending';
      case ErrandStatus.assigned:
        return 'Assigned';
      case ErrandStatus.inProgress:
        return 'In Progress';
      case ErrandStatus.pickupComplete:
        return 'Pickup Complete';
      case ErrandStatus.inTransit:
        return 'In Transit';
      case ErrandStatus.delivered:
        return 'Delivered';
      case ErrandStatus.completed:
        return 'Complete';
      case ErrandStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get statusColor {
    switch (this) {
      case ErrandStatus.pending:
      case ErrandStatus.assigned:
        return Colors.orange;
      case ErrandStatus.inProgress:
      case ErrandStatus.pickupComplete:
      case ErrandStatus.inTransit:
        return Colors.blue;
      case ErrandStatus.delivered:
      case ErrandStatus.completed:
        return Colors.green;
      case ErrandStatus.cancelled:
        return Colors.red;
    }
  }

  bool get isCompleted => this == ErrandStatus.completed;
  bool get isActive => [
    ErrandStatus.assigned,
    ErrandStatus.inProgress,
    ErrandStatus.pickupComplete,
    ErrandStatus.inTransit,
  ].contains(this);
}