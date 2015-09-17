<html>
<body>
<table rules="all">
  <caption>
    <a href="http://paularmstrong.github.io/swig" target="swig">learn swig</a>
    |
    <a href="./template/test.swig">template source</a>
  </caption>
  <tbody>
  {% for o in objects.rows %}
  <tr>
    <td>{{o.object_name}}</td>
    <td>{{o.subobject_name}}</td>
    <td>{{o.object_type}}</td>
    <td>{{o.created}}</td>
  </tr>
  {% endfor %}
  </tbody>
</table>
</body>
</html>