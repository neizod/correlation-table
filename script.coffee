---
---

elements = ['earth', 'wind', 'fire', 'water']


_add_table = () ->
    table = $('<table>')
    $('#main').append(table)


_add_row = () ->
    table = $('#main table')
    table.append($('<tr>'))


_add_cell = (content='') ->
    cell = $('<td>')
    cell.html(content)
    row = $('#main table:last-child')
    row.append(cell)
    cell


_add_cell_label = (value='', vtext=false) ->
    p = $('<p>')
    p.html(value)
    if vtext
        p.attr('class', 'vtext')
    else
        p.attr('class', 'htext')
    _add_cell(p)


_add_cell_info = (x, y) ->
    cell = _add_cell()
    cell.data('x', x)
    cell.data('y', y)
    cell.attr('class', 'cell')


make_correlation_table = (elements) ->
    _add_table()
    _add_row()
    _add_cell()
    for element in elements
        _add_cell_label(element, vtext=true)
    for element, y in elements
        _add_row()
        _add_cell_label(element)
        for _, x in elements
            _add_cell_info(x, y)


$(document).ready ->
    make_correlation_table(elements)

    $('.cell').click ->
        cell = $(this)
        if cell.hasClass('explored')
            cell.removeClass('explored')
        else
            cell.addClass('explored')
