# React fundamentals

## Rethinking Web app development at Facebook

React was created by Facebook to address the challenges of building complex UIs with data that changes over time. It allows developers to create reusable UI components and manage the state of their applications in a more systematic way. React has since become one of the most popular front-end development frameworks, with a vibrant ecosystem and a large community of developers.

In the early 2010s, Facebook developers had a problem. Thousands of people were complaining about "phantom messages".

Users would see a little 1 notification badge by the "messages" icon, suggesting they had new messages. But when they'd click it, **there wouldn't be anything new**, just the same old messages.

At the time, the UI had 3 separate locations where message state was presented

![facebook-annotated-chat-ui.png](React%20fundamentals%205db0b3f6927041eabb4d24353f313524/facebook-annotated-chat-ui.png)

Users were getting phantom messages because these 3 parts of the UI were powered by separate views, and those views were getting out of sync.

This might seem like a trivial problem to solve, but Facebook is a tremendously complex app, with hundreds of developers across dozens of teams all collaborating, adding new features, moving fast and breaking things. Every week, some new edge-case would crop up, leading to phantom messages. It was like playing whack-a-mole; every time they fixed a bug, a new one would pop up.

The team eventually solved this problem by migrating to an experimental new internal tool: React. This problem, along with so many others, disappeared.

[https://youtu.be/nYkdrAPrdcw?t=624](https://youtu.be/nYkdrAPrdcw?t=624)

The truly magical thing about React is that we don't have to worry about keeping our state (held in JavaScript) and our UI (in the DOM?) in sync. 

With React, we write code that describes what the UI *should be* based on the application state. React will be able to figure out what's changed, and will update the UI accordingly.

## Hello world

```jsx
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

### Import dependencies

```jsx
import React from 'react';
import { createRoot } from 'react-dom/client';
```

At the very top of the file, we have two import statements, using the native JavaScript module system. We're importing the core React library from the `react` dependency, as well as a `createRoot` function from `react-dom`

If you're wondering why there are two separate packages, this is because React itself is “platform agnostic”. We have the core `react` package, which manages all of the magic we talked about in the previous lesson, and then there are different platform-specific *renderers*:

- `react-dom` for the web
- `react-native` for mobile (iOS / Android) or desktop (Windows / MacOS) applications
- `react-three-fiber` for 3D scenes using WebGL and Three.js
- https://github.com/chentsulin/awesome-react-renderer

### Create a react element

```jsx
const element = React.createElement(
  'p',
  { id: 'hello' },
  'Hello World!'
);
```

`React.createElement` is a function that accepts 3 or more arguments:

1. The type of the element to create.
2. The properties we want this element to have.
3. The element's contents, what the element should have as children.

This function returns a “React element”. React elements are plain old JavaScript objects. If we inspect it with `console.log(element)`, we'll see something like this:

```jsx
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

This JavaScript object is a *description* of a paragraph tag, with an ID of `hello`, containing the text `"Hello World!"`. 

This information will be used to construct the *actual* paragraph we can see in-browser.

`type`: The type of the element to create

`key`: a special string attribute you need to include when creating lists of elements. Keys help React identify which items have changed, are added, or are removed.

`ref`:

`props`:

`id`:

`children`: The DOM is organized as a tree. Much like a family tree, individual elements can have parents and grand-parents, siblings, and children. React elements form a hierarchy just like DOM elements do.

`_owner` and `_store`, are meant to be used internally by React

### Render the application

```jsx
const container = document.querySelector('#root');
const root = createRoot(container);
root.render(element);
```

This element will be our application's container. When we render our React application, it will create and append new DOM element(s) to this container.

```jsx
<div id="root"></div>
```

This element will be our application's container. When we render our React application, it will create and append new DOM element(s) to this container.

Old, This is how React applications were rendered in version 17 and earlier. Starting in version 18 (released in March 2022), the API was changed to the `createRoot` and `render` combo shown above.

```jsx
import ReactDOM from 'react-dom';

ReactDOM.render(
  element,
  container
);
```

## Build your own react

The best ways to learn how something works is to build our own simplified version of it.

Exercise #1

Acceptance criteria:

- A link should be shown in the “Result” pane, linking to wikipedia.org, and with the text “Read more on Wikipedia”.
- It should work with *any element type* (eg. anchors, paragraphs, buttons…)
- It should handle *all HTML attributes* (eg. `href`, `id`, `disabled`…)
- The element should contain the text specified under `children`. `children` will always be a string.

[billowing-dawn-j04q7r - CodeSandbox](https://codesandbox.io/s/billowing-dawn-j04q7r?file=/src/index.js)

```jsx
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

## Understanding JSX

```jsx
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

If we try to run this JSX code in the browser, we'll get an error. We need to "compile" our code into plain JS. The JSX we write gets converted into `React.createElement`.

### **Reserved words**

[Lexical grammar - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar#reserved_words](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar#reserved_words))

```jsx
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

- `for` is changed to `htmlFor`
- `class` is changed to `className`

```jsx
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

### **Case-sensitive tags**

HTML is a case-insensitive language.

```jsx
<MAIN>
  <HEADER>
    <H1>Hello World!</H1>
  </HEADER>
  <P>
    This HTML is so loud!
  </P>
</MAIN>
```

JSX, by contrast, is case-sensitive. Our tags must all be lowercase:

```jsx
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

### **Case-sensitive attributes**

In JSX, our attributes need to be “camelCase”

HTML

```html
<video
  src="/videos/cat-skateboarding.mp4"
  autoplay={true}
>
```

In JSX, we need to capitalize the “p” in “autoplay”, since “auto” and “play” are distinct words:

```jsx
<video
    src="/videos/cat-skateboarding.mp4"
    autoPlay={true}
  />
);
```

You'll get a helpful warning in the developer tools if you make a mistake.

There are two exceptions to the "camelCasing" of attributes: `data` attributes and `ARIA` attributes.

```jsx
const element = (
  <button
    data-test-id="close-dialog-button"
    aria-label="Close dialog"
  >
    <img alt="" src="/icons/x.svg" />
  </button>
);
```

### **Inline styles**

In HTML, the `style` attribute allows us to apply some styles inline, to a specified element:

```jsx
<h1 style="font-size: 2rem;">
  Hello World!
</h1>
```

In JSX, `style` instead takes an object:

```jsx
const element = (
  <h1 style={{ fontSize: '2rem' }}>
    Hello World!
  </h1>
);
```

All CSS properties are written in “camelCase”. Every dash is replaced by capitalizing the subsequent word:

- `background-position` becomes `backgroundPosition`
- `border-bottom-color` becomes `borderBottomColor`

For vendor prefixes like `-webkit-font-smoothing`, we capitalize the first letter as well: **`W**ebkitFontSmoothing`.

React will automatically apply the `px` suffix for certain CSS properties. For example:

```jsx
<div
  style={{
    width: 200, // Equivalent to `width: 200px`
    paddingTop: 8, // Equivalent to `padding-top: 8px`
  }}
>
```

## Components

Component is a bundle of markup, styles, and logic that controls everything about a specific part of the user interface.

![Separation_Of_Concerns.jpg](React%20fundamentals%205db0b3f6927041eabb4d24353f313524/Separation_Of_Concerns.jpg)

In React, components can be defined as JavaScript `functions`. They can also be defined using the `class` keyword, though this method is an older alternative that isn't seen as often these days.

```jsx
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

```jsx
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

### Base syntax

React components are regular JavaScript functions, but **their names must start with a capital letter** or they won’t work!

To understand why, we need to dig a bit deeper into the JSX-to-JS transformation.

```jsx
const elem1 = <h1>Hello!</h1>
const elem2 = <DestinyGreeting />
```

```jsx
const elem1 = React.createElement('h1', null, 'Hello!');
const elem2 = React.createElement(DestinyGreeting, null);
```

**A React element is a description of a thing we want to create.** In some cases, we want to create a DOM node, like an `<h1>` or a `<p>`. In other cases, we want to create a *component instance*.

The first argument that we pass to `React.createElement` is the “type” of the thing we want to create. For the first element, it's a string (`"h1"`). For the second element, it's a *function!* It's `DestinyGreeting`, and not `"DestinyGreeting"`.

If our component had a lower-case function name, React would render a `<destinygreeting>` HTML element, instead of processing it as a component.

### Importing and Exporting a component

The `export default` prefix is a [standard JavaScript syntax](https://developer.mozilla.org/docs/web/javascript/reference/statements/export) (not specific to React). It lets you mark the main function in a file so that you can later import it from other files

```jsx
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

```jsx
// index.js

import React from 'react';
import { createRoot } from 'react-dom/client';
import DestinyGreeting from './DestinyGreating';
//import { DestinyGreeting } from './DestinyGreating';

const container = document.querySelector('#root');
const root = createRoot(container);
root.render(<DestinyGreeting />);
```

### Props

Props are like arguments to a function: they allow us to pass data to our components, so that the components can include customizations based on the data.

Every parent component can pass some information to its child components by giving them props. Props might remind you of HTML attributes, but you can pass any JavaScript value through them, including objects, arrays, and functions.

```jsx
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

### Children

Special or not?

```jsx
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

// ---
<RedButton>
	Click me
</RedButton>
// equivalent
<RedButton children="Click me!" />
```

The only thing that makes `children` special is that I can choose to pass it between the open/close tags. In every other way, it's the same as any other prop.

### Fragments

In JSX you should always return a single root element.

```jsx
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

JSX looks like HTML, but under the hood it is transformed into plain JavaScript objects. You can’t return two objects from a function without wrapping them into an array. This explains why you also can’t return two JSX tags without wrapping them into another tag or a Fragment.

```jsx
function something() {
  let arr = [1, 2, 3];

  return (
    arr.push(4)
    arr.push(5)
  );
}
```

```jsx
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

### Iteration

```jsx
const data = [
	{name: 'Creola Katherine Johnson', job: 'mathematician'},
	{name: 'Mario José Molina-Pasquel Henríquez', job: 'chemist'},
	{name: 'Percy Lavon Julian', job: 'chemist',},
  {name: 'Subrahmanyan Chandrasekhar', job: 'astrophysicist'
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

We will get this error `Warning: Each child in a list should have a unique "key" prop.`

Keys tell React which array item each component corresponds to, so that it can match them up later. This becomes important if your array items can move (e.g. due to sorting), get inserted, or get deleted. A well-chosen `key` helps React infer what exactly has happened, and make the correct updates to the DOM tree.

Rules of keys:

- **Keys must be unique among siblings.** However, it’s okay to use the same keys for JSX nodes in *different* arrays.
- **Keys must not change** or that defeats their purpose! Don’t generate them while rendering.
- Avoid setting `key` to the array index *if* the items can be reordered.

React doesn't actually know specifically what happens when we change data. All React sees is the before/after. React has to figure out how to change the DOM to match this new snapshot.

### Conditional rendering

With the curly brackets, we can add JavaScript *expressions* within our JSX. Unfortunately, though, we can't add JavaScript *statements*.

```jsx
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

Why doesn't this work? Well, let's consider how this would compile down to JavaScript:

```jsx
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

The problem is that we can't put an `if` statement in the middle of a function call like this — to look at a simpler example, it would be equivalent to trying to do this:

```jsx
console.log(
  if (isLoggedIn) {
    "Logged in!"
  } else {
    "Not logged in"
  }
)
```

**With &&**

```jsx
function Friend({ name, isOnline }) {
  return (
    <li className="friend">
      {isOnline && <div className="green-dot" />}
      {name}
    </li>
  );
}
```

In JSX, `{cond && <A />}` means *if `cond`, render `<A />`, otherwise nothing.*

If the left-hand value (`isOnline`) is falsy, the expression short-circuits, and evaluates to `isOnline`, which resolves to `false`. If that value is truthy, however, it evaluates to whatever's on the right-hand side of the operator (`<div className="green-dot" />`).

```jsx
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

The `&&` operator doesn't return `true` or `false`. It returns either the left-hand side or the right-hand side. So, when our list is empty, this expression evaluates to `0`.

**Always use boolean values with &&**

**Falsy values**

React will ignore most falsy values like `false` or `null`, but it won't ignore the number zero.

```jsx
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

**With Ternary**

```jsx
condition ? firstExpression : secondExpression
```

In JSX, `{cond ? <A /> : <B />}` means *if `cond`, render `<A />`, otherwise `<B />`*.

```jsx
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

## States

### Event handlers

```jsx
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

Should be camelCase and without parentheses.

```jsx
// ✅ We want to do this:
<button onClick={doSomething} />

// 🚫 Not this:
<button onClick={doSomething()} />
```

**Arguments**

```jsx
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

### useState

```jsx
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

To create a state variable, we use the `useState` function. This function takes a single argument: the initial value. In this case, that value initializes to `0`.

The `useState` hook returns an array containing two items:

1. The current value of the state variable. We've decided to call it `count`.
2. A function we can use to update the state variable. We named it `setCount`.

The initial value can be a function as well. If we need to do an expensive operation to calculate the initial value.

```jsx
const [count, setCount] = React.useState(() => {
  return window.localStorage.getItem('saved-count');
});
```

**Core React loop**

```jsx
function Counter() {
  const [count, setCount] = React.useState(0);

  return (
    <button onClick={() => setCount(count + 1)}>
      Value: {count}
    </button>
  );
}
```

```jsx
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

When this code runs, `React.createElement` produces a React element, which is a plain JavaScript object.

```jsx
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

Our React element, that JavaScript object, is describing this DOM structure. React takes that description, and turns it into the real thing. It creates a `<button>` DOM node and appends it to the page.

React elements are essentially descriptions of the UI we want. We're saying in this case that we want a button that contains the text “Value: 0”.

**Now, let's think about what happens when this button is clicked.**

The `setCount` function will be called, and we'll pass in a new value. `count` will be incremented, from 0 to 1.

**Whenever a state variable is updated, it triggers a *re-render*.** Once again, React will call the `Counter` function. This creates a brand-new React element, a new description of the UI we want.

**Each render is like taking a snapshot.** We generate a description that shows what the UI should look like, based on the component's props/state. It's like a photo that captures what things were like at a moment in time.

```jsx
<button>
Value: 0
</button>
```

```jsx
<button>
Value: 1
</button>
```

The user clicked the button, and this second snapshot was generated. React now has to figure out how to *update* the DOM, so that it matches this latest snapshot.

This process is known as *`reconciliation`*. Using fancy optimized algorithms, React figures out what's changed. It sees that the button's text content has changed from "Value: 0" to "Value: 1".

Once React has solved the puzzle and worked out what's different, it will need to *`commit`* these changes. With surgical precision, it updates the DOM, taking care to only tweak the things that need to be tweaked.

![Screenshot 2023-03-22 at 14.01.34.png](React%20fundamentals%205db0b3f6927041eabb4d24353f313524/Screenshot_2023-03-22_at_14.01.34.png)

### **Rendering vs. Painting**

**What the term “render” means?**

```jsx
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

```jsx
age: 16

{
  type: 'p',
  key: null,
  ref: null,
  props: {},
  children: "You're not old enough!",
}
```

```jsx
age: 17

{
  type: 'p',
  key: null,
  ref: null,
  props: {},
  children: "You're not old enough!",
}
```

In both cases, `age` is less than 18, and so we wind up with **the exact same UI**. As a result, *no DOM mutation happens at all.*

So, when we talk about “re-rendering” a component, we aren't *necessarily* saying that anything will change in the DOM! We're saying we're going to check if anything's changed. *If* we spot a difference between snapshots, React will need to update the DOM, but it will be a precisely-targeted minimal change.

When React *does* change a part of the DOM, the browser will need to *re-paint*. A re-paint is when the pixels on the screen are re-drawn because a part of the DOM was mutated. This is done natively by the browser when the DOM is edited with JavaScript

Summarize:

- Any screen update in a React app happens in three steps:
    1. Trigger
    2. Render
    3. Commit
- You can use Strict Mode to find mistakes in your components
- React does not touch the DOM if the rendering result is the same as last time

**State updates are asynchronous**

```jsx
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

## **Data Binding**

When building web applications, we often want to sync a bit of state to a particular form input. For example, a "username" field should be bound to the value of a `username` state variable.

This is commonly known as “data binding”. Most front-end frameworks offer a way to bind a particular bit of state to a particular form control.

[reverent-clarke-3u6jx3 - CodeSandbox](https://codesandbox.io/s/reverent-clarke-3u6jx3?file=/src/App.js)

```jsx
import React from 'react';

function SearchForm() {
  const [searchTerm, setSearchTerm] = React.useState('cats!');
  
  return (
    <>
      <form>
        <label htmlFor="search-input">
          Search:
        </label>
        <input
          type="text"
          id="search-input"
          value={searchTerm}
          onChange={(event) => {
            setSearchTerm(event.target.value);
          }}
        />
      </form>

      <p>
        Search term: {searchTerm}
      </p>

      <button
        onClick={() => setSearchTerm(Math.random())}
      >
        Click me
      </button>
    </>
  );
}

export default SearchForm;
```

## **Synthetic events**

React uses a “synthetic” event system. The events are special objects created by React, *not* the standard events used in JavaScript.

Why does React do this? Several reasons:

- It can ensure consistency, removing some edge-case issues with native events being implemented slightly differently between browsers.
- It can include a few helpful “extras”, to improve the developer experience
- In earlier versions, this event system had a slight beneficial impact on performance, though those changes have since been removed. If you see references online to “event pooling” or `event.persist()`, you can ignore them, since this system was removed in React 17.

If you ever need to access the “real” event object, you can access it like this:

```jsx
<input
  onChange={(event) => {
    const realEvent = event.nativeEvent;

    console.log(realEvent); // DOM InputEvent object
  }}
/>
```

If you're particularly curious about events, you can learn more by reading the [official “Events” documentation](https://react.dev/reference/react-dom/components/common#react-event-object).

## **Controlled vs. Uncontrolled inputs**

When we set the `value` attribute on a form control, we tell React that it should be a *controlled element*. The word “controlled” has a specific definition in React; it means that React is managing the input.

By contrast, if we don't set `value`, the input is an *uncontrolled element*. This means that React doesn't do any management.

There's a golden rule here: **An element should always either be controlled or uncontrolled.** React doesn't like when we flip an element from one to the other.

```jsx
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

Try typing in the text input, and then switch to the “Console” tab. You should see a warning that begins like this:

**`Warning:** A component is changing an uncontrolled input to be controlled.`

This is weird, right? This input *is* controlled! We're setting `value={username}` from the very first render!

**Here's the problem:** `username` is undefined at first, since there is no default value in the state hook. 

```jsx
// 🚫 Incorrect. `username` will flip from `undefined` to a string:
const [username, setUsername] = React.useState();

// ✅ Correct. `username` will always be a string:
const [username, setUsername] = React.useState('');
```

Props vs State

Rerender

## Hooks

## Docs

- [https://beta.reactjs.org/](https://beta.reactjs.org/)
- [https://kentcdodds.com/blog](https://kentcdodds.com/blog)
- [https://www.joshwcomeau.com/latest/](https://www.joshwcomeau.com/latest/)

Next:

- State
- Re-renders
- Hooks
- useEffect
- useCallback
- useMemo
- useRef