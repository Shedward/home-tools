
import { a_app } from './app/app.js';
import { a_form } from './app/form.js';
import { a_fetch } from './app/fetch.js';
import { a_table } from './app/table.js';

const a = {
  app: a_app,
  form: a_form,
  fetch: a_fetch,
  table: a_table
};

window.a = a;

export { a };

