XScaffold(
  title: "Profile",
  body: XFutureBuilder<Map>(
    future: XApi.get("/users/1"),
    builder: (data) => XText("Name: ${data['name']}"),
  ),
)