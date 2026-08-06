# Diagram Data Contract

## Contents

- [Layout grid](#layout-grid)
- [Nodes](#nodes)
- [Scenarios](#scenarios)
- [Arrow routing](#arrow-routing)
- [Validation checklist](#validation-checklist)

## Layout grid

Each scenario places nodes on a column-by-row grid with `[column, row]`. Columns increase left to right; rows increase top to bottom. Prefer the natural flow direction from lower to higher columns.

Use separate rows to create routing lanes. More whitespace is better than an arrow crossing a node.

## Nodes

Define every possible node once:

```js
const NODES = {
  warehouse: {
    w: 520,
    h: 200,
    zone: 'company',
    kind: 'auth',
    icon: '🏭',
    title: 'Warehouse',
    sub: 'fulfillment center',
    lines: [
      ['holds', 'SKUs · inventory'],
      ['picks', 'robotic + manual']
    ]
  }
};

const ZONE_LABELS = {
  company: 'Acme Logistics · internal',
  external: 'Public / customers'
};
```

Fields:

- `w`, `h`: Canvas-unit dimensions. Typical width is 480–560; increase height for additional detail rows.
- `zone`: Optional grouping key. Nodes with the same non-empty value receive a shared zone boundary.
- `kind`: Accent role supported by the template: `edge` (blue), `auth` (green), `store` (gold), `backend` (orange), or a neutral value such as `external` or `actor`.
- `icon`: One emoji or short visual mark.
- `title`, `sub`: Node name and short role.
- `lines`: One to four `[label, value]` detail rows. Use an empty label for continuation text.

Use `const ZONE_LABELS = {};` when no zones are needed.

## Scenarios

Define two to six scenarios:

```js
const SC = {
  placeOrder: {
    btn: 'Place order',
    title: 'Customer places an order',
    desc: 'How an order enters the system and is confirmed.',
    grid: {
      customer: [0, 1],
      gateway: [1, 0],
      warehouse: [2, 1],
      inventory: [3, 0]
    },
    flow: [
      ['customer:r:0.4', 'gateway:l:0.6', 1, { net: 'HTTPS', ep: 'POST /orders', bow: -26 }],
      ['gateway:r:0.6', 'warehouse:l:0.3', 2, { net: 'queue', ep: 'enqueue order', bow: -26 }],
      ['warehouse:r:0.2', 'inventory:l:0.6', 3, { net: 'query', ep: 'reserve stock', bow: -26 }],
      ['warehouse', 'warehouse', 4, { net: 'compute', ep: 'allocate pick list' }],
      [
        'warehouse:l:0.7',
        'customer:r:0.7',
        5,
        { ret: 1, net: 'HTTPS', ep: '201 confirmed', bow: 55 }
      ]
    ],
    steps: [
      ['Customer → gateway: <code>POST /orders</code>', 0],
      ['Gateway → warehouse: enqueue the order', 0],
      ['Warehouse → inventory: reserve stock', 0],
      ['Warehouse: allocate the pick list', 0],
      ['Warehouse → customer: <code>201 confirmed</code>', 1]
    ],
    note: ['', 'A stock-out fails before confirmation.']
  }
};
```

Scenario fields:

- `btn`: Short tab label.
- `title`: Scenario heading.
- `desc`: One or two sentences.
- `grid`: Only nodes present in this scenario, mapped to `[column, row]`.
- `flow`: Ordered arrow definitions.
- `steps`: Ordered `[htmlText, isReturn]` entries, exactly one per flow entry.
- `note`: `[severity, html]`, where severity is `''` or `'warn'`.

Arrow form:

```js
['<from>', '<to>', <number>, { net, ep, bow, ret }]
```

- Endpoint syntax is `<nodeId>:<side>:<fraction>` where side is `l`, `r`, `t`, or `b` and fraction is 0–1.
- `net` is the domain-specific channel label.
- `ep` is the message or action detail.
- `bow` controls curvature; small values suit adjacent hops and larger values route around nodes.
- `ret: 1` marks a dashed return path.
- A local step uses the same node at both ends and `net: 'compute'`.

The renderer derives visible numbering from array order. Keep the numeric field sequential for readability.

## Arrow routing

- Keep most hops between adjacent columns.
- Move intermediaries to another row when they block a direct path.
- Route long paths above or below the main row with a larger bow.
- Give return paths a larger or opposite bow so they do not overlap requests.
- Prefer adding rows or columns over compressing the layout.

## Validation checklist

- Two to six scenarios.
- Every scenario has equal-length `flow` and `steps` arrays.
- Return flags match between arrows and steps.
- Every grid node participates in at least one flow.
- Node references exist in `NODES`.
- Arrows do not cross unrelated boxes.
- Channel labels are consistent within the domain.
- Required domain steps are not omitted merely to simplify the picture.
