class Massage {
  final int? id;
  final String? nome;
  final String? descricao;
  final String? imagemUrl;

  Massage({
    this.id,
    this.nome,
    this.descricao,
    this.imagemUrl,
  });



  factory Massage.fromJson(Map<String, dynamic> json) {
    return Massage(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      imagemUrl: json['imagemUrl'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'imagemUrl': imagemUrl,
    };
  }
}
