
import { a_app } from './app/app.js';
import { a_form } from './app/form.js';
import { a_fetch } from './app/fetch.js';
import { a_table } from './app/table.js';
import { a_select } from './app/select.js';
import { a_elem } from './app/elem.js';
import { a_hourly_grid } from './app/hourly_grid.js';

const a = {
  app: a_app,
  form: a_form,
  fetch: a_fetch,
  table: a_table,
  select: a_select,
  elem: a_elem,
  hourly_grid: a_hourly_grid
};

window.a = a;

export { a };

