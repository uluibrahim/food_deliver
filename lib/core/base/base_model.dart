abstract class BaseModel<T> {
  T formJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
