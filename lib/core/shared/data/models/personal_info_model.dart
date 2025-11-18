class PersonalInfoModel {
  final String id;
  final String name;
  final String title;
  final String email;
  final String phone;
  final String location;
  final String github;
  final String linkedin;
  final String bio;
  final String profileImage;
  final Map<String, String> stats;

  const PersonalInfoModel({
    required this.id,
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.location,
    required this.github,
    required this.linkedin,
    required this.bio,
    required this.profileImage,
    required this.stats,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'email': email,
      'phone': phone,
      'location': location,
      'github': github,
      'linkedin': linkedin,
      'bio': bio,
      'profileImage': profileImage,
      'stats': stats,
    };
  }

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      github: json['github'] ?? '',
      linkedin: json['linkedin'] ?? '',
      bio: json['bio'] ?? '',
      profileImage: json['profileImage'] ?? '',
      stats: Map<String, String>.from(json['stats'] ?? {}),
    );
  }

  PersonalInfoModel copyWith({
    String? id,
    String? name,
    String? title,
    String? email,
    String? phone,
    String? location,
    String? github,
    String? linkedin,
    String? bio,
    String? profileImage,
    Map<String, String>? stats,
  }) {
    return PersonalInfoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      github: github ?? this.github,
      linkedin: linkedin ?? this.linkedin,
      bio: bio ?? this.bio,
      profileImage: profileImage ?? this.profileImage,
      stats: stats ?? this.stats,
    );
  }
}

class PersonalInfoData {
  static const PersonalInfoModel defaultInfo = PersonalInfoModel(
    id: 'default',
    name: 'Mohamed Abdelqawi',
    title: 'Flutter Developer',
    email: 'mohamedahbd545@gmail.com',
    phone: '+201060796400',
    location: 'Fayoum, Egypt',
    github: 'https://github.com/mohamed12344556',
    linkedin: 'https://linkedin.com/in/mohamed-abdelqawi',
    bio: 'Passionate Flutter developer with 3+ years of experience building beautiful and performant mobile applications.',
    profileImage: 'assets/images/profile.png',
    stats: {
      'experience': '3+',
      'projects': '20+',
      'clients': '90+',
    },
  );
}
