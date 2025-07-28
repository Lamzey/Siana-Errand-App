// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'errands_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrandModel _$ErrandModelFromJson(Map<String, dynamic> json) => ErrandModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  status: $enumDecode(_$ErrandStatusEnumMap, json['status']),
  agent: AgentModel.fromJson(json['agent'] as Map<String, dynamic>),
  pickupLocation: LocationModel.fromJson(
    json['pickupLocation'] as Map<String, dynamic>,
  ),
  destination: LocationModel.fromJson(
    json['destination'] as Map<String, dynamic>,
  ),
  timeDetails: TimeModel.fromJson(json['timeDetails'] as Map<String, dynamic>),
  payment: PaymentModel.fromJson(json['payment'] as Map<String, dynamic>),
  mapCoordinates: (json['mapCoordinates'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  notes: json['notes'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
);

Map<String, dynamic> _$ErrandModelToJson(ErrandModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': _$ErrandStatusEnumMap[instance.status]!,
      'agent': instance.agent,
      'pickupLocation': instance.pickupLocation,
      'destination': instance.destination,
      'timeDetails': instance.timeDetails,
      'payment': instance.payment,
      'mapCoordinates': instance.mapCoordinates,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$ErrandStatusEnumMap = {
  ErrandStatus.pending: 'pending',
  ErrandStatus.assigned: 'assigned',
  ErrandStatus.inProgress: 'in_progress',
  ErrandStatus.pickupComplete: 'pickup_complete',
  ErrandStatus.inTransit: 'in_transit',
  ErrandStatus.delivered: 'delivered',
  ErrandStatus.completed: 'completed',
  ErrandStatus.cancelled: 'cancelled',
};

AgentModel _$AgentModelFromJson(Map<String, dynamic> json) => AgentModel(
  id: json['id'] as String,
  name: json['name'] as String,
  profileImage: json['profileImage'] as String,
  rating: (json['rating'] as num).toDouble(),
  totalRatings: (json['totalRatings'] as num).toInt(),
  agentCode: json['agentCode'] as String,
  vehicle: VehicleModel.fromJson(json['vehicle'] as Map<String, dynamic>),
  phoneNumber: json['phoneNumber'] as String,
  isOnline: json['isOnline'] as bool,
);

Map<String, dynamic> _$AgentModelToJson(AgentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profileImage': instance.profileImage,
      'rating': instance.rating,
      'totalRatings': instance.totalRatings,
      'agentCode': instance.agentCode,
      'vehicle': instance.vehicle,
      'phoneNumber': instance.phoneNumber,
      'isOnline': instance.isOnline,
    };

VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) => VehicleModel(
  make: json['make'] as String,
  model: json['model'] as String,
  color: json['color'] as String,
  plateNumber: json['plateNumber'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$VehicleModelToJson(VehicleModel instance) =>
    <String, dynamic>{
      'make': instance.make,
      'model': instance.model,
      'color': instance.color,
      'plateNumber': instance.plateNumber,
      'type': instance.type,
    };

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      address: json['address'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      additionalInfo: json['additionalInfo'] as String?,
      type: $enumDecode(_$LocationTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'additionalInfo': instance.additionalInfo,
      'type': _$LocationTypeEnumMap[instance.type]!,
    };

const _$LocationTypeEnumMap = {
  LocationType.home: 'home',
  LocationType.office: 'office',
  LocationType.business: 'business',
  LocationType.other: 'other',
};

TimeModel _$TimeModelFromJson(Map<String, dynamic> json) => TimeModel(
  scheduledTime: DateTime.parse(json['scheduledTime'] as String),
  actualStartTime: json['actualStartTime'] == null
      ? null
      : DateTime.parse(json['actualStartTime'] as String),
  actualEndTime: json['actualEndTime'] == null
      ? null
      : DateTime.parse(json['actualEndTime'] as String),
  estimatedDurationMinutes: (json['estimatedDurationMinutes'] as num).toInt(),
  timeZone: json['timeZone'] as String,
);

Map<String, dynamic> _$TimeModelToJson(TimeModel instance) => <String, dynamic>{
  'scheduledTime': instance.scheduledTime.toIso8601String(),
  'actualStartTime': instance.actualStartTime?.toIso8601String(),
  'actualEndTime': instance.actualEndTime?.toIso8601String(),
  'estimatedDurationMinutes': instance.estimatedDurationMinutes,
  'timeZone': instance.timeZone,
};

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
  cardLast4: json['cardLast4'] as String?,
  paymentStatus: $enumDecode(_$PaymentStatusEnumMap, json['paymentStatus']),
  paidAt: json['paidAt'] == null
      ? null
      : DateTime.parse(json['paidAt'] as String),
  transactionId: json['transactionId'] as String?,
);

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'cardLast4': instance.cardLast4,
      'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
      'paidAt': instance.paidAt?.toIso8601String(),
      'transactionId': instance.transactionId,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.debitCard: 'debit_card',
  PaymentMethod.creditCard: 'credit_card',
  PaymentMethod.cash: 'cash',
  PaymentMethod.wallet: 'wallet',
  PaymentMethod.bankTransfer: 'bank_transfer',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.processing: 'processing',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.refunded: 'refunded',
};
