<html>
<head>
    <title>View Guides</title>
</head>
<body>
    <h1>Available Guides</h1>
    <table>
        <thead>
            <tr>
                <th>Title</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="guide" items="${guides}">
                <tr>
                    <td>
                        <a href="/public/guides/${guide.id}">${guide.title}</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
