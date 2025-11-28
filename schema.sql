-- Supabase schema for ERP Corabastos
-- Run this in Supabase SQL Editor (requires project privileges)

-- Roles and permissions
create table if not exists roles (
  id bigint generated always as identity primary key,
  name text unique not null,
  description text
);

create table if not exists role_permissions (
  id bigint generated always as identity primary key,
  role_id bigint references roles(id) on delete cascade,
  module text not null,
  can_view boolean default true,
  can_edit boolean default false,
  can_create boolean default false,
  can_delete boolean default false
);

create table if not exists users (
  id bigint generated always as identity primary key,
  username text unique not null,
  pass text not null,
  fullname text,
  phone text,
  email text,
  role_id bigint references roles(id) on delete set null,
  created_at timestamp default now()
);

-- Fundaciones and puntos_envio
create table if not exists fundaciones (
  id bigint generated always as identity primary key,
  nit text unique not null,
  nombre text not null,
  direccion text,
  created_at timestamp default now()
);

create table if not exists puntos_envio (
  id bigint generated always as identity primary key,
  fundacion_id bigint references fundaciones(id) on delete cascade,
  barrio text,
  localidad text,
  ciudad text,
  direccion text,
  tel1 text,
  tel2 text,
  encargada text
);

-- Items, conductores, placas
create table if not exists items (
  id bigint generated always as identity primary key,
  nombre text unique not null,
  descripcion text,
  precio numeric default 0
);

create table if not exists conductores (
  id bigint generated always as identity primary key,
  nombre text not null,
  documento text unique,
  telefono text,
  empresa text
);

create table if not exists placas (
  id bigint generated always as identity primary key,
  placa text unique not null,
  tipo text
);

-- Pedidos and pedido_items
create table if not exists pedidos (
  id bigint generated always as identity primary key,
  codigo text unique not null,
  fundacion_id bigint references fundaciones(id),
  punto_id bigint references puntos_envio(id),
  conductor_id bigint references conductores(id),
  placa_id bigint references placas(id),
  peaje numeric default 0,
  transporte numeric default 0,
  total numeric default 0,
  created_at timestamp default now()
);

create table if not exists pedido_items (
  id bigint generated always as identity primary key,
  pedido_id bigint references pedidos(id) on delete cascade,
  item_id bigint references items(id),
  cantidad integer default 1,
  kilos numeric,
  embalaje text,
  precio numeric
);

-- Auditoria
create table if not exists auditoria (
  id bigint generated always as identity primary key,
  fecha timestamp default now(),
  usuario text,
  accion text,
  detalle jsonb
);

-- Default roles
insert into roles (name, description) values ('admin', 'Control total del sistema') on conflict do nothing;
insert into roles (name, description) values ('general', 'Puede trabajar con permisos limitados') on conflict do nothing;
insert into roles (name, description) values ('lector', 'Solo lectura') on conflict do nothing;

-- Default admin user (change password after)
insert into users (username, pass, fullname, role_id)
select 'admin', '3134630773', 'Administrador', id from roles where name='admin'
on conflict do nothing;
