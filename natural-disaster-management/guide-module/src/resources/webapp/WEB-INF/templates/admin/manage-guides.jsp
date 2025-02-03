<html>
<head>
    <title>Manage Guides</title>
</head>
<body>
    <h1>Admin: Manage Guides</h1>
    <a href="/admin/guides/create">Create New Guide</a>
    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="guide" items="${guides}">
                <tr>
                    <td>${guide.title}</td>
                    <td>
                        <a href="/admin/guides/${guide.id}/delete">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
