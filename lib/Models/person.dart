class Person {
  Person(this.id, this.name, this.lastName, this.age);

  final String id;
  final String name;
  final String lastName;
  final int age;

  getId() => this.id;

  getName() => this.name;

  getLastName() => this.lastName;

  getAge() => this.age;
}
