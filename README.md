<h1>Dragon Byte</h1>
	<h2>Starting Point</h2>
		<p>A 42x42 cursor with a dragon drawing.</p>
	<h2>Installation And Usage</h2>
		<p>This repository contains the source files of the cursor and a wizard script to create the necessary ports. This cursor can be embed in your web project or used inside the X11 graphical environment.</p>
		<p>Both installations have different instructions, but both have common dependencies, that you need to install before trying to do anything else:</p>
		<ul>
			<li>Ruby</li>
			<p>This is the programming language used in the wizard script.</p>
			<li>ImageMagick</li>
			<p>This is the utility tool used to create PNG files from the source files.</p>
		</ul>
		<p>You will also need to download this repository. If you have <code>git</code> installed, you can do it using the following command:</p>
		<pre><code>git clone --depth=1 https://github.com/skippyr/dragon_byte</code></pre>
		<p>This will cone this repository to the directory <code>dragon_byte</code> in your current directory. The flag <code>--depth</code> with value <code>1</code> specifies to <code>git</code> that you only want to download the latest commit instead of the whole commit as it does by default.</p>
		<p>If you do not have <code>git</code> installed, you can download this repository from its page on GitHub: access that page, click on the button labeled <code>Code</code> on the top of the page, then click on the button <code>Download ZIP</code> that will appear in the floating menu. This will download a compressed file with the repository, you just have to unzip it in a formidable directory.</p>
		<h3>Installation For Web Projects</h3>
			<p>After ensuring that all the common dependencies are installed, follow these steps:</p>
			<ul>
				<li>Access the repository's directory.</li>
				<pre><code>cd dragon_byte</code></pre>
				<li>Execute the wizard script using the <code>create-web-port</code> command.</li>
				<pre><code>ruby scripts/wizard.rb create-web-port</code></pre>
				<p>This will create the directory <code>distributions</code> in the root of the repository's directory containing all the required files for your web project:</p>
				<ul>
					<li>Images of the cursor will be under <code>distributions/cursors</code> in PNG format.</li>
					<li>A stylesheet containing variables will be at <code>distributions/stylesheet.css</code>.</li>
					<li>A copy of the license of this project will be at <code>distributions/LICENSE</code>.</li>
				</ul>
				<li>Copy the <code>distributions</code> directory created to a formidable directory in your web project.</li>
				<li>Import the stylesheets of the directory you have just copied inside your <code>HTML</code> file. You can use a <code>link</code> tag for that:</li>
				<pre><code>
&lt;link
	rel="stylesheet"
	href=""
/&gt;
				</code></pre>
				<p>You can use the example above, but you will have to insert the relative path to include that stylesheet yourself in the <code>href</code> attribute shown.</p>
				<li>Write the CSS rules you need to apply the cursor inside the stylesheet that you imported. It already has all the necessary variables defined and in scope for you to do it. Every variable is prefixed with <code>dragon-byte</code> to make them unique. Want a usage example? What about applying the <code>default</code> cursor for your <code>body</code> element:</li>
				<pre><code>
body
{ cursor: var(--dragon-byte-default); }
				</code></pre>
				<p>You will have to manually apply the cursor variants you need to your HTML elements.</p>
			</ul>
	<h2>Issues And Contributions</h2>
		<p>Learn how to report issues, questions and ideas and how to contribute to this project by reading its <a href="https://skippyr.github.io/materials/pages/contributions_guideline.html">contributions guideline</a>.</p>
	<h2>License</h2>
		<p>Dragon Breath is released under the terms of the MIT License. You can refer to the license as the file <code><a href="https://github.com/skippyr/dragon_byte/blob/main/LICENSE">LICENSE</a></code> in the root directory of this repository.</p>
		<p>Copyright (c) 2023, Sherman Rofeman. MIT License.</p>
