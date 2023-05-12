<h1>Dragon Byte</h1>
	<h2>Starting Point</h2>
		<p>A 42x42 cursor with a dragon drawing.</p>
		<img src="./preview/preview.png"/>
	<h2>Installation And Usage</h2>
		<p>This repository contains basically the source files of the cursor but also a wizard script to help you automatically create all the necessary files to use this cursor:</p>
		<ul>
			<li>In a web project.</li>
			<li>In X11.</li>
		</ul>
		<p>Both installations have different instructions, but both have common dependencies too, that you will need to install before trying to do anything else:</p>
		<ul>
			<li>Ruby</li>
			<p>This is the programming language used in the wizard script.</p>
			<li>ImageMagick</li>
			<p>This is the utility tool used to create PNG files from the source files.</p>
		</ul>
		<p>You will also need to download this repository. If you have <code>git</code> installed, you can do it using the following command:</p>
		<pre><code>git clone --depth=1 https://github.com/skippyr/dragon_byte</code></pre>
		<p>This will clone this repository to the directory <code>dragon_byte</code> in your current directory. The flag <code>--depth</code> with value <code>1</code> specifies to <code>git</code> that you only want to download the latest commit instead of the whole commit tree as it does by default.</p>
		<p>If you do not have <code>git</code> installed, you can download this repository from its page on GitHub: access that page, click on the button labeled <code>Code</code> on the top of the page, then click on the button <code>Download ZIP</code> that will appear in the floating menu. This will download a compressed file with the repository, you just have to unzip it in a formidable directory.</p>
		<h3>Installation For Web Projects</h3>
			<p>After ensuring that all the common dependencies are installed, follow these steps:</p>
			<ul>
				<li>Access the repository's directory.</li>
				<pre><code>cd dragon_byte</code></pre>
				<li>Execute the wizard script using the <code>create-web-port</code> command.</li>
				<pre><code>ruby scripts/wizard.rb create-web-port</code></pre>
				<p>This will create the directory <code>distributions</code> in the repository's root directory containing all the required files for your web project:</p>
				<ul>
					<li>Images of the cursor will be under <code>distributions/cursors</code> in PNG format.</li>
					<li>A stylesheet containing variables will be at <code>distributions/dragon_byte.css</code>.</li>
					<li>A copy of the license of this project will be at <code>distributions/LICENSE</code>.</li>
				</ul>
				<li>Copy the <code>distributions</code> directory created to a formidable directory in your web project.</li>
				<li>Import the stylesheet file <code>dragon_byte.css</code> of the directory you have just copied inside your <code>HTML</code> file. You can use a <code>link</code> tag for that. Here is a template that you can use:</li>
				<pre><code>
&lt;link
	rel="stylesheet"
	href=""
/&gt;
				</code></pre>
				<p>You still have to insert the relative path to include that stylesheet yourself, in the <code>href</code> attribute shown.</p>
				<li>Write the CSS rules you need to apply the cursor inside the stylesheet that you imported. It already has all the necessary variables defined and in scope for you to do it. Every variable is prefixed with <code>dragon-byte</code> to make them unique. Want a usage example? What about applying the <code>default</code> cursor for your <code>body</code> element:</li>
				<pre><code>
body
{ cursor: var(--dragon-byte-default); }
				</code></pre>
				<p>Applying the remaining variables of the cursor is up to you: you will have to manually apply them to your page elements.</p>
			</ul>
		<h3>Installation For X11</h3>
			<p>For this installation, along with the common dependencies, you will have to download one more:</p>
			<ul>
				<li>xcursorgen</li>
				<p>This is the utility tool from X11 that allows developers to create an X11 cursor from PNG files.</p>
			</ul>
			<p>After installing all the dependencies, follow these steps:</p>
			<li>Access the repository's directory.</li>
			<pre><code>cd dragon_byte</code></pre>
			<li>Execute the wizard script using the <code>create-x11-port</code> command.</li>
			<pre><code>ruby scripts/wizard.rb create-x11-port</code></pre>
			<p>This will create the directory <code>distributions</code> in the repository's root directory containing all the required files for X11:</p>
			<ul>
				<li>The cursor files will be under <code>distributions/cursors</code>.</li>
				<li>A file containing the metadata of the cursor will be at <code>distributions/index.theme</code>.</li>
				<li>A copy of the license of this project will be at <code>distributions/LICENSE</code>.</li>
			</ul>
			<li>Move the <code>distributions</code> directory created to your user's icons directory. You might have to create it first:</li>
			<pre><code>mkdir -p ${HOME}/.local/share/icons</code></pre>
			<p>The flag <code>-p</code> specified to <code>mkdir</code> to create all the directories recursively if they do not exist.</p>
			<p>Assuming that you are in the repository's root directory:</p>
			<pre><code>mv -r distributions ${HOME}/.local/share/icons/dragon_byte</code></pre>
			<p>The flag <code>-r</code> specifies to <code>mv</code> that you want to move a directory recursively: moving it and its contents too.</p>
			<li>Apply the cursor using your system's settings application or by using an Xresource rule.</p>
			<li>Restart X11 for your changes to be properly set.</li>
	<h2>Issues And Contributions</h2>
		<p>Learn how to report issues, questions and ideas and how to contribute to this project by reading its <a href="https://skippyr.github.io/materials/pages/contributions_guideline.html">contributions guideline</a>.</p>
	<h2>License</h2>
		<p>Dragon Breath is released under the terms of the MIT License. You can refer to the license as the file <code><a href="https://github.com/skippyr/dragon_byte/blob/main/LICENSE">LICENSE</a></code> in the root directory of this repository.</p>
		<p>Copyright (c) 2023, Sherman Rofeman. MIT License.</p>
