---
---

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


_add_cell_info = (x, y, mark=false) ->
    cell = _add_cell()
    cell.attr('data-x', x)
    cell.attr('data-y', y)
    cell.attr('class', 'cell')
    _add_explored(x, y, mark)


explore = (x, y, correlation) ->
    if x != y
        correlation[y][x] = not correlation[y][x]
    correlation[x][y] = not correlation[x][y]


_add_explored = (x, y, mark) ->
    cell = $("td.cell[data-x='#{x}'][data-y='#{y}']")
    if mark
        cell.addClass('explored')
    else
        cell.removeClass('explored')


load_local = () ->
    if not localStorage.getItem('elements')? or not localStorage.getItem('correlation')?
        elements = ['earth', 'wind', 'fire', 'water']
        correlation = ((false for _ in elements) for _ in elements)
    else
        elements = JSON.parse(localStorage.getItem('elements'))
        correlation = JSON.parse(localStorage.getItem('correlation'))
    [elements, correlation]


save_local = (elements, correlation) ->
    localStorage.setItem('elements', JSON.stringify(elements))
    localStorage.setItem('correlation', JSON.stringify(correlation))


reset_local = () ->
    localStorage.removeItem('elements')
    localStorage.removeItem('correlation')


make_cell_color = (x, y, mark) ->
    if x != y
        _add_explored(y, x, mark)
    _add_explored(x, y, mark)


make_correlation_table = (elements, correlation) ->
    _add_table()
    _add_row()
    _add_cell()
    for element in elements
        _add_cell_label(element, vtext=true)
    for element, y in elements
        _add_row()
        _add_cell_label(element)
        for _, x in elements
            _add_cell_info(x, y, correlation[y][x])


attach_table_listener = (elements, correlation) ->
    $('.cell').click ->
        cell = $(this)
        x = cell.data('x')
        y = cell.data('y')
        mark = explore(x, y, correlation)
        make_cell_color(x, y, mark)
        save_local(elements, correlation)


draw = (elements, correlation) ->
    $('#main').html('')
    make_correlation_table(elements, correlation)
    attach_table_listener(elements, correlation)


expand_element = (name, elements, correlation) ->
    elements.push(name)
    for line in correlation
        line.push(false)
    correlation.push(false for _ in elements)
    save_local(elements, correlation)


$(document).ready ->
    [elements, correlation] = load_local()
    draw(elements, correlation)

    $('#add-element').click ->
        name = prompt('Input name of the new element:')
        expand_element(name, elements, correlation)
        draw(elements, correlation)

    $('#reset').click ->
        ok = confirm('Are you really want to reset the progree?')
        if ok
            reset_local()
            [elements, correlation] = load_local()
            draw(elements, correlation)
