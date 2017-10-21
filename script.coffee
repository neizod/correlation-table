---
---

elements = ['earth', 'wind', 'fire', 'water']


_add_table = () ->
    table = $('<table>')
    $('#main').append(table)


_add_row = () ->
    table = $('#main table')
    table.append($('<tr>'))


_add_cell = (value='', vtext=false) ->
    p = $('<p>')
    p.html(value)
    if vtext
        p.attr('class', 'vtext')
    else
        p.attr('class', 'htext')
    cell = $('<td>')
    cell.html(p)
    row = $('#main table:last-child')
    row.append(cell)


make_correlation_table = (elements) ->
    _add_table()
    _add_row()
    _add_cell()
    for element in elements
        _add_cell(element, vtext=true)
    for element in elements
        _add_row()
        _add_cell(element)


$(document).ready ->
    make_correlation_table(elements)
