# React fundamentals
_2023_

---

## Agenda
* Rethinking Web app development at Facebook
* Hello world
* Build your own react
* Understanding JSX
* Components
* States


---

## Rethinking Web app development at Facebook

[![IMAGE_ALT](https://img.youtube.com/vi/nYkdrAPrdcw/0.jpg)](https://www.youtube.com/watch?t=624&v=nYkdrAPrdcw&feature=emb_imp_woyt)

---

React was created by Jordan Walke, a software engineer at Meta, who released an early prototype of React called "FaxJS". He was influenced by XHP, an HTML component library for PHP. It was first deployed on Facebook's News Feed in 2011 and later on Instagram in 2012. It was open-sourced at JSConf US in May 2013.

---

**React isn’t an MVC framework.**
React is a library for building composable user interfaces. It encourages the creation of reusable UI components which present data that changes over time.

---

The truly magical thing about React is that we don't have to worry about keeping our state (held in JavaScript) and our UI (in the DOM?) in sync. 

With React, we write code that describes what the UI *should be* based on the application state. React will be able to figure out what's changed, and will update the UI accordingly.

---

## Hello World

---

```javascript
// 1. Import dependencies
import React from 'react';
import { createRoot } from 'react-dom/client';

// 2. Create a React element
const element = React.createElement(
  'p',
  { id: 'hello' },
  'Hello World!'
);

// 3. Render the application
const container = document.querySelector('#root');
const root = createRoot(container);
root.render(element);
```

---

### Import dependencies
```javascript
import React from 'react';
import { createRoot } from 'react-dom/client';
```

---

- `react-dom` for the web
- `react-native` for mobile (iOS / Android) or desktop (Windows / MacOS) applications
- `react-three-fiber` for 3D scenes using WebGL and Three.js
- https://github.com/chentsulin/awesome-react-renderer

---

### Create a react element

```javascript
const element = React.createElement(
  'p',
  { id: 'hello' },
  'Hello World!'
);
```

---

If we inspect it with `console.log(element)`, we'll see something like this:

```javascript
{
  type: "p",
  key: null,
  ref: null,
  props: {
    id: 'hello',
    children: 'Hello World!',
  },
  _owner: null,
  _store: {}
}
```
---

### Render the application

```javascript
const container = document.querySelector('#root');
const root = createRoot(container);
root.render(element);
```

---

Old way

```javascript
import ReactDOM from 'react-dom';

ReactDOM.render(
  element,
  container
);
```
---

## Build your own React

[Task #1](https://codesandbox.io/s/billowing-dawn-j04q7r?file=/src/index.js)

---

- A link should be shown in the “Result” pane, linking to wikipedia.org, and with the text “Read more on Wikipedia”.
- It should work with *any element type* (eg. anchors, paragraphs, buttons…)
- It should handle *all HTML attributes* (eg. `href`, `id`, `disabled`…)
- The element should contain the text specified under `children`. `children` will always be a string.

---

```javascript
function render(reactElement, containerDOMElement) {
  // 1. create a DOM element
  const domElement = document.createElement(reactElement.type);

  // 2. update properties
  domElement.innerText = reactElement.children;
  for (const key in reactElement.props) {
    const value = reactElement.props[key];
    domElement.setAttribute(key, value);
  }

  // 3. put it in the container
  containerDOMElement.appendChild(domElement);
}
```

---

## Understanding JSX

---

```javascript
// Old way:
const element = React.createElement(
  'p',
  {
    id: 'hello',
  },
  'Hello World!'
);

// New way:
const element = (
  <p id="hello">
    Hello World!
  </p>
);
```

---

### Reserved words
[Lexical grammar - MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar#reserved_words)

---

### In HTML

```javascript
const element = (
  <div>
    <label for="name">
      Name:
    </label>
    <input
      id="name"
      class="fun-input"
    />
  </div>
);
```

---

### In JSX

```javascript
const element = (
  <div>
    <label htmlFor="name">
      Name:
    </label>
    <input
      id="name"
      className="fun-input"
    />
  </div>
);
```

---

## Case-sensitive tags

---

### HTML is a case-insensitive language.

```html
<MAIN>
  <HEADER>
    <H1>Hello World!</H1>
  </HEADER>
  <P>
    This HTML is so loud!
  </P>
</MAIN>
```

---

### JSX, by contrast, is case-sensitive. Our tags must all be lowercase.

```javascript
const element = (
  <main>
    <header>
      <h1>Hello World!</h1>
    </header>
    <p>
      This HTML is so loud!
    </p>
  </main>
);
```

---

## Case-sensitive attributes

---

### In HTML

```html
<video
  src="/videos/cat-skateboarding.mp4"
  autoplay={true}
>
```

### In JSX

```javascript
<video
    src="/videos/cat-skateboarding.mp4"
    autoPlay={true}
  />
);
```

---

## There are two exceptions to the "camelCasing" of attributes: data attributes and ARIA attributes.

```javascript
const element = (
  <button
    data-test-id="close-dialog-button"
    aria-label="Close dialog"
  >
    <img alt="" src="/icons/x.svg" />
  </button>
);
```

---

## Inline styles

---

### In HTML

```html
<h1 style="font-size: 2rem;">
  Hello World!
</h1>
```

### In JSX

```javascript
const element = (
  <h1 style={{ fontSize: '2rem' }}>
    Hello World!
  </h1>
);
```

---

All CSS properties are written in “camelCase”. Every dash is replaced by capitalizing the subsequent word:

- `background-position` becomes `backgroundPosition`
- `border-bottom-color` becomes `borderBottomColor`

---

### React will automatically apply the px suffix for certain CSS properties. For example:

```javascript
<div
  style={{
    width: 200, // Equivalent to `width: 200px`
    paddingTop: 8, // Equivalent to `padding-top: 8px`
  }}
>
```

---

# Components

---

![React separation of concerns](/assets/Separation_Of_Concerns.jpg "React separation of concerns")

---

### In React, components can be defined as JavaScript functions. They can also be defined using the class keyword, though this method is an older alternative that isn't seen as often these days.

---

```javascript
import React from 'react';
import { createRoot } from 'react-dom/client';

function DestinyGreeting() {
  return (
    <p
      style={{
        fontSize: '1.25rem',
        textAlign: 'center',
        color: 'red',
      }}
    >
      Greetings, Destiny team!
    </p>
  );
}

const container = document.querySelector('#root');
const root = createRoot(container);
root.render(<DestinyGreeting />);
```

---

```javascript
import React from 'react';
import { createRoot } from 'react-dom/client';

class DestinyGreeting extends React.Component {
	render() {
	  return (
	    <p
	      style={{
	        fontSize: '1.25rem',
	        textAlign: 'center',
	        color: 'red',
	      }}
	    >
	      Greetings, Destiny team!
	    </p>
	  );
	}
}

const container = document.querySelector('#root');
const root = createRoot(container);
root.render(<DestinyGreeting />);
```

---

## Base syntax

React components are regular JavaScript functions, but their names must start with a capital letter or they won’t work!

---

```javascript
const elem1 = <h1>Hello!</h1>
const elem2 = <DestinyGreeting />
```

```javascript
const elem1 = React.createElement('h1', null, 'Hello!');
const elem2 = React.createElement(DestinyGreeting, null);
```

---

The first argument that we pass to `React.createElement` is the “type” of the thing we want to create. For the first element, it's a string (`"h1"`). For the second element, it's a *function!* It's `DestinyGreeting`, and not `"DestinyGreeting"`.

If our component had a lower-case function name, React would render a `<destinygreeting>` HTML element, instead of processing it as a component.

---

# Importing and Exporting a component

---

```javascript
// DestinyGreeting.js

import React from 'react';

export default function DestinyGreeting() {
  return (
    <p
      style={{
        fontSize: '1.25rem',
        textAlign: 'center',
        color: 'red',
      }}
    >
      Greetings, Destiny team!
    </p>
  );
}
```

---

```javascript
// index.js

import React from 'react';
import { createRoot } from 'react-dom/client';
import DestinyGreeting from './DestinyGreating';
//import { DestinyGreeting } from './DestinyGreating';

const container = document.querySelector('#root');
const root = createRoot(container);
root.render(<DestinyGreeting />);
```

---

# Props

---

Props are like arguments to a function: they allow us to pass data to our components, so that the components can include customizations based on the data.

Every parent component can pass some information to its child components by giving them props. Props might remind you of HTML attributes, but you can pass any JavaScript value through them, including objects, arrays, and functions.

---

```javascript
import React from 'react';

// TODO: object destructuring
export default function TeamGreeting(props) {
  return (
    <p
      style={{
        fontSize: '1.25rem',
        textAlign: 'center',
        color: 'red',
      }}
    >
      Greetings, {props.team} team!
    </p>
  );
}

// From an another component
<TeamGreeting name="Destiny" />
```

---

# Children

Special or not?

---

```javascript
function RedButton({ children }) {
  return (
    <button
      style={{
        color: 'white',
        backgroundColor: 'red',
      }}
    >
      {children}
    </button>
  );
}


<RedButton>Click me</RedButton>
// valid?, equivalent?
<RedButton children="Click me!" />
```

---

# Fragments

---

### In JSX you should always return a single root element.

```javascript
import React from 'react';

// TODO: div, <>, <React.Fragment>
function App() {
	return (

		  <h1>Hedy Lamarr's Todos</h1>
		  <img 
		    src="https://i.imgur.com/yXOvdOSs.jpg" 
		    alt="Hedy Lamarr" 
		    class="photo"
		  >
		
	);
}
```

---

```javascript
function something() {
  let arr = [1, 2, 3];

  return (
    arr.push(4)
    arr.push(5)
  );
}
```

---

```javascript
// #1
return (
  React.createElement('h1', {}, 'Hedy Lamarrs Todos')
  React.createElement('img', {src: '..', alt: '..'}, null)
);

// #2
return (
  React.createElement(
    'div',
    {},
    React.createElement('h1', {}, 'Hedy Lamarrs Todos'),
    React.createElement('img', {src: '..', alt: '..'}, null),
  );
);
```

---

# Iteration

---

```javascript
const data = [
  {name: 'Creola Katherine Johnson', job: 'mathematician'},
  {name: 'Mario José Molina-Pasquel Henríquez', job: 'chemist'},
  {name: 'Percy Lavon Julian', job: 'chemist'},
  {name: 'Subrahmanyan Chandrasekhar', job: 'astrophysicist'},
];

function App() {
  return (
    <ul>
      {data.map(contact => <ContactCard                  
        name={contact.name}
        job={contact.job}
      />)}
    </ul>
  );
}

export default App;
```

---

### Rules of keys:

- **Keys must be unique among siblings.** However, it’s okay to use the same keys for JSX nodes in *different* arrays.
- **Keys must not change** or that defeats their purpose! Don’t generate them while rendering.
- Avoid setting `key` to the array index *if* the items can be reordered.

---

# Conditional rendering

---

## With the curly brackets, we can add JavaScript expressions within our JSX. Unfortunately, though, we can't add JavaScript statements.

---

```javascript
function Friend({ name, isOnline }) {
  return (
    <li className="friend">
      {if (isOnline) {
        <div className="green-dot" />
      }}
      {name}
    </li>
  );
}
```

---

```javascript
return React.createElement(
    'li',
    { className: 'friend' },
    if (isOnline) {
      React.createElement('div', { className: 'green-dot' });
    },
    name
  );
}
```
---

### Look at a simpler example

```javascript
console.log(
  if (isLoggedIn) {
    "Logged in!"
  } else {
    "Not logged in"
  }
)
```

---

# With &&

---

### In JSX, {cond && `<A />`} means if cond is true, render `<A />`, otherwise nothing.

```javascript
function Friend({ name, isOnline }) {
  return (
    <li className="friend">
      {isOnline && <div className="green-dot" />}
      {name}
    </li>
  );
}
```

---

### Always use boolean values with &&

```javascript
import ShoppingList from './ShoppingList';

function App() {
  const shoppingList = [];
  const numOfItems = shoppingList.length;

  return (
    <div>
      {numOfItems && (
        <ShoppingList items={shoppingList} />
      )}
    </div>
  );
}

export default App;
```

---

# Falsy values

React will ignore most falsy values like false or null, but it won't ignore the number zero.

---

```javascript
function App() {
  return (
    <ul>
      <li>false: {false}</li>
      <li>undefined: {undefined}</li>
      <li>null: {null}</li>
      <li>Empty string: {''}</li>
      <li>Zero: {0}</li>
      <li>NaN: {NaN}</li>
    </ul>
  );
}

export default App;
```

---

# With Ternary

---

```javascript
condition ? firstExpression : secondExpression
```

---

```javascript
const isLoggedIn = !!user;

  return (
    <>
      {isLoggedIn
        ? <AdminDashboard />
        : <p>Please login first</p>}
    </>
  );
}
```

---

# States

---

## Event handlers

```javascript
function App() {
  function doSomething() {
    // Stuff here
  }

  return (
    <button onClick={doSomething}>
      Click me!
    </button>
  );
}
```

---

### Should be camelCase and without parentheses.

```javascript
// ✅ We want to do this:
<button onClick={doSomething} />

// 🚫 Not this:
<button onClick={doSomething()} />
```

---

### Arguments

```javascript
function App() {
  function setTheme(theme) {
		// do something
	}

	return (
		<button onClick={setTheme('dark')}>
		  Toggle theme
		</button>
	);

	// Should use a wrapper function.
	return (
		<button onClick={() => setTheme('dark')}>
		  Toggle theme
		</button>
	);
}
```

---

# useState

---

```javascript
import React from 'react';

function Counter() {
  const [count, setCount] = React.useState(0);

  return (
    <button onClick={() => setCount(count + 1)}>
      Value: {count}
    </button>
  );
}

export default Counter;
```

---

### The `useState` hook returns an array containing two items:

1. The current value of the state variable. We've decided to call it `count`.
2. A function we can use to update the state variable. We named it `setCount`.

---

### The initial value can be a function as well. If we need to do an expensive operation to calculate the initial value.

```javascript
const [count, setCount] = React.useState(() => {
  return window.localStorage.getItem('saved-count');
});
```

---

# Core React loop

---

```javascript
function Counter() {
  const [count, setCount] = React.useState(0);

  return (
    <button onClick={() => setCount(count + 1)}>
      Value: {count}
    </button>
  );
}
```

---

```javascript
function Counter() {
  const [count, setCount] = React.useState(0);

  return React.createElement(
    'button',
    { onClick: () => setCount(count + 1) },
    'Value: ',
    count
  );
}
```

---

### Our React element, that JavaScript object, is describing this DOM structure. React takes that description, and turns it into the real thing. It creates a `<button>` DOM node and appends it to the page.

```javascript
{
  type: 'button',
  key: null,
  ref: null,
  props: {
    onClick: () => setCount(count + 1),
  },
  children: 'Value: 0',
  _owner: null,
  _store: { validated: false }
}
```

---

**Now, let's think about what happens when this button is clicked.**

The `setCount` function will be called, and we'll pass in a new value. `count` will be incremented, from 0 to 1.

**Whenever a state variable is updated, it triggers a *re-render*.** Once again, React will call the `Counter` function. This creates a brand-new React element, a new description of the UI we want.

**Each render is like taking a snapshot.** We generate a description that shows what the UI should look like, based on the component's props/state. It's like a photo that captures what things were like at a moment in time.

---

```javascript
<button>
Value: 0
</button>
```

```javascript
<button>
Value: 1
</button>
```

---

This process is known as *`reconciliation`*. Using fancy optimized algorithms, React figures out what's changed. It sees that the button's text content has changed from "Value: 0" to "Value: 1".

---

![React core loop](/assets/trigger_render-commit.png "React core loop")

---

# Rendering vs. Painting
What the term “render” means?

---

```javascript
function AgeLimit({ age }) {
  if (age < 18) {
    return (
      <p>You're not old enough!</p>
    );
  }

  return (
    <p>Hello, adult!</p>
  );
}
```

---

```javascript
age: 16

{
  type: 'p',
  key: null,
  ref: null,
  props: {},
  children: "You're not old enough!",
}
```

```javascript
age: 17

{
  type: 'p',
  key: null,
  ref: null,
  props: {},
  children: "You're not old enough!",
}
```

---

# State updates are asynchronous

---

```javascript
function App() {
  const [count, setCount] = React.useState(0);

  return (
    <>
      <p>
        You've clicked {count} times.
      </p>
      <button
        onClick={() => {
          setCount(count + 1);

          console.log(count)
        }}
      >
        Click me!
      </button>
    </>
  );
}

// What value would you see in the developer console?

// 0
// 1
// undefined
// None of above
```

---

# Forms and Data binding

---

When building web applications, we often want to sync a bit of state to a particular form input. For example, a "username" field should be bound to the value of a username state variable.

This is commonly known as “data binding”. Most front-end frameworks offer a way to bind a particular bit of state to a particular form control.

---

### Here's what this typically looks like in React:

[Link to example](https://codesandbox.io/s/reverent-clarke-3u6jx3?file=/src/App.js)

---

- The value attribute works differently in React than it does in HTML.
  - In HTML, value sets the default value, and can be edited
  - In React, value locks the input to the specified value, and it becomes read-only.
- By setting value equal to our searchTerm state variable, we ensure that the input will always display the search term.
- When we add an onChange handler, we see that the input actually does briefly update to show the new value. The problem is that React will undo that change immediately after the change event fires, before the browser has even had the time to complete a single repaint.
- We can call setSearchTerm with the input's current value as a way to persist that edit. When React re-renders, the input will be updated to show the updated value held in state.

---

# Synthetic events

---

## React uses a “synthetic” event system. The events are special objects created by React, not the standard events used in JavaScript.

---

### Why does React do this? Several reasons:

- It can ensure consistency, removing some edge-case issues with native events being implemented slightly differently between browsers.
- It can include a few helpful “extras”, to improve the developer experience
- In earlier versions, this event system had a slight beneficial impact on performance, though those changes have since been removed. If you see references online to “event pooling” or `event.persist()`, you can ignore them, since this system was removed in React 17.

---

### If you ever need to access the “real” event object, you can access it like this:

```javascript
<input
  onChange={(event) => {
    const realEvent = event.nativeEvent;

    console.log(realEvent); // DOM InputEvent object
  }}
/>
```

---

# Controlled vs. Uncontrolled inputs

---

When we set the value attribute on a form control, we tell React that it should be a controlled element. The word “controlled” has a specific definition in React; it means that React is managing the input.

By contrast, if we don't set value, the input is an uncontrolled element. This means that React doesn't do any management.

There's a golden rule here: **An element should always either be controlled or uncontrolled.** React doesn't like when we flip an element from one to the other.

---

```javascript
import React from 'react';

function SignupForm() {
  // No default value:
  const [username, setUsername] = React.useState();
  
  return (
    <form>
      <label htmlFor="username">
        Select a username:
      </label>
      <input
        type="text"
        id="username"
        value={username}
        onChange={event => {
          setUsername(event.target.value);
        }}
      />
    </form>
  );
}

export default SignupForm;
```

---

```javascript
// 🚫 Incorrect. `username` will flip from `undefined` to a string:
const [username, setUsername] = React.useState();

// ✅ Correct. `username` will always be a string:
const [username, setUsername] = React.useState('');
```





---

# Docs

- [https://react.dev/](https://react.dev/)
- [https://kentcdodds.com/blog](https://kentcdodds.com/blog)
- [https://www.joshwcomeau.com/latest/](https://www.joshwcomeau.com/latest/)