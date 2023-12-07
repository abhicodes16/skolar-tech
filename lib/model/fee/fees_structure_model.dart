class FeesStructureModel {
	bool? success;
	String? message;
	int? responseCode;
	List<Data>? data;

	FeesStructureModel({this.success, this.message, this.responseCode, this.data});

	FeesStructureModel.fromJson(Map<String, dynamic> json) {
		success = json['success'];
		message = json['message'];
		responseCode = json['responseCode'];
		if (json['data'] != null) {
			data = <Data>[];
			json['data'].forEach((v) { data!.add(new Data.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = this.success;
		data['message'] = this.message;
		data['responseCode'] = this.responseCode;
		if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Data {
	String? className;
	String? period;
	String? feeHead;
	String? amount;

	Data({this.className, this.period, this.feeHead, this.amount});

	Data.fromJson(Map<String, dynamic> json) {
		className = json['class_'];
		period = json['period_'];
		feeHead = json['feeHead'];
		amount = json['amount'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['class_'] = this.className;
		data['period_'] = this.period;
		data['feeHead'] = this.feeHead;
		data['amount'] = this.amount;
		return data;
	}
}
