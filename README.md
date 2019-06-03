# DHSI-ethical-dataviz

These are code snippets to accompany the course, Ethical Data Visualization: Taming Treacherous Data, by Christopher Church and Katherine Hepworth.

This course is taught at the Digital Humanities Summer Institute (DHSI)

This course teaches participants how to use ethical visualization principles and practices to visualize treacherous, or culturally problematic, data. Such data includes racist historical documents, ideologically laden materials, culturally controversial texts, politically charged topics, gendered works, etc. Aimed at people who work with culturally sensitive datasets, and those who are interested in critical reflection on visualization practice, the course will combine hands-on activities and discussion. Participants will create data visualizations using R and instructor-provided stock code, and then interrogate their visualizations, identifying the extent and severity of the ethical pitfalls they inevitably contain. By the end of the week, participants will have produced several visualizations and prepared a position statement on ethical visualization appropriate for their own cultural and disciplinary contexts. No previous knowledge in coding, R, or visualizations is required. Participants are welcome to bring their own treacherous data, or they may use sample projects provided by the instructors. If you are unsure as to whether your data will work in this class, please feel welcome to contact the instructors in advance. 

All work herein is available under a Creative Commons license.

<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.

------ 
<h1>Syllabus, Taming Treacherous Data, DHSI 2019</h1>
<h2>Day 1 Overview: Introducing Treacherous Data</h2>
<h3>Morning 1: First Principles and Visualization Examples</h3>
<h4>10:15 to Noon (1.75 hours)</h4>
<ul>
<li><strong><em>45 minutes: </em></strong><em>Class overview and three question introduction </em>
<ul>
<li><em>9 minute Class overview</em></li>
<li><em>26 minute Three question introductions:</em>
<ul>
<li>Where are you based?</li>
<li>How would you describe what you do in 1 short sentence?</li>
<li>Which adjective would describe you best right now?</li>
</ul>
</li>
<li><em>10 minute IMPROV adjective activity</em></li>
</ul>
</li>
<li><strong><em>10 minutes:</em></strong> <a href="http://www.emergingsf.org/wp-content/uploads/2017/08/EBMC_AgreemntsMulticulturalInteractions15.09.13-copy.pdf"><em>EBMC Multicultural Interactions</em></a></li>
<li><strong><em>30 minutes: </em></strong><em>Lecture and discussion:</em>
<ul>
<li><em>Introduction to Dataviz, visual conventions &amp; first principles &mdash; Visual hierarchy, legibility, and color</em></li>
</ul>
</li>
<li><strong><em>30 minutes: </em></strong><em>Lecture &amp; Discussion: Statistics</em>
<ul>
<li><a href="https://mathwithbaddrawings.com/2016/07/13/why-not-to-trust-statistics/">com/2016/07/13/why-not-to-trust-statistics</a></li>
</ul>
</li>
</ul>
<h3>Afternoon 1: Building Your First Treacherous Visualization</h3>
<h4>1:30 to 4:00 (2.5 hours)</h4>
<ul>
<li><strong><em>30 minutes:</em></strong><em> Lecture &amp; Discussion: Statistics continued</em></li>
<li><strong><em>120 minutes: </em></strong><em>Discussion &amp; Activity: Stopping distances in snow and ice</em>
<ul>
<li><em>10 minute Discussion: </em>
<ul>
<li>Snow and Ice: </li>
<ul>
<li><a href="https://github.com/cmchurch/DHSI-ethical-dataviz/blob/master/images/snow-ice_BBC.jpg">BBC</a></li>
<li><a href="https://www.rac.co.uk/drive/advice/learning-to-drive/stopping-distances/">RAC</a></li></ul>
<li>What is ethical and unethical about this chart?</li>
<li>What are the limits of ethics in this visualization context?</li>
</ul>
</li>
<li><em>20 minute Analog activity, in pairs: </em>
<ul>
<li>Discuss what specific design decisions would improve this chart to make it more ethical</li>
<li>Recreate this chart on graph paper to demonstrate your decisions</li>
</ul>
</li>
<li><em>60 minute Digital activity, in pairs:</em>
<ul>
<li>Open RStudio Cloud (https://rstudio.cloud) and log in</li>
<li>Create a new project in RStudio Cloud</li>
<li>Copy the R code from: <a href="https://github.com/cmchurch/DHSI-ethical-dataviz/tree/master/r-code">https://github.com/cmchurch/DHSI-ethical-dataviz/tree/master/r-code</a></li>
<li>Paste code into your new project</li>
<li>With guidance from instructors, edit code to make the chart more ethical</li>
</ul>
</li>
<li><em>30 Sharing results &amp; reflection</em></li>
</ul>
</li>
</ul>
<h3>Optional After-Class Reading</h3>
<ul>
<li>Hepworth, K. J., &ldquo;Big Data Visualisation: Promises and Pitfalls&rdquo;. <em>Communication Design Quarterly</em>. 4(4), 7&ndash;19.</li>
</ul>
<h2>Day 2: Racist Historical Data</h2>
<h3>Morning 2: Visualization and Graphic Conventions</h3>
<h4>9:00am - 12pm (3 hours)</h4>
<ul>
<li><strong><em>30 minutes: </em></strong><em>Integration</em>
<ul>
<li><em>10 minute IMPROV pass the sound activity</em></li>
<li><em>20 minute design and ethics refresher group discussion </em></li>
</ul>
</li>
<li><strong><em>30 minutes: </em></strong><em>The Dark Arts and </em>Good, Bad, and Ugly Activity: <em>Examples and discussion: </em>Exploring Sample Visualizations &mdash;Best and worst practices</li>
<li><strong><em>10 minutes: </em></strong><em>Break</em></li>
<li><strong><em>110 minutes:</em></strong><em> Activity &amp; Discussion: Gun Deaths in Florida </em>
<ul>
<li><em>70 minute pair activity Make Gun Deaths in Florida charts (analog and/or digital)</em>
<ul>
<li>10 minute real-world controversy</li>
<li>5 minute exploration of FDLE data</li>
<li>15 minute discussion best ways of visualizing data</li>
<li>20 minute download Gun Deaths in Florida R code and open in a new project on your instance of RStudio Cloud</li>
</ul>
</li>
<li><em>30 minute sharing results and reflection</em></li>
<li><em>10 minute discussion of other versions</em></li>
</ul>
</li>
</ul>
<h3>Afternoon 2: Visualizing Race</h3>
<h4>1:30pm to 4:00pm (2.5 hours)</h4>
<ul>
<li><strong><em>30-45 minutes: </em></strong><em>Lecture: </em>Historicizing visualization &mdash; narrative and graphic visualization conventions through history</li>
<li><strong><em>80 minutes:</em></strong><em> Examples &amp; Discussion: </em>Exploring Sample Visualizations &mdash; Challenging Racism with Visualizations - W.E.B. Dubois
<ul>
<li>10 minute read the following: <a href="https://www.theguardian.com/world/2017/feb/14/web-du-bois-racism-data-paris-african-americans-jobs">https://www.theguardian.com/world/2017/feb/14/web-du-bois-racism-data-paris-african-americans-jobs</a></li>
<li>For further context, also take a look at the following: <a href="https://www.smithsonianmag.com/history/first-time-together-and-color-book-displays-web-du-bois-visionary-infographics-180970826/">https://www.smithsonianmag.com/history/first-time-together-and-color-book-displays-web-du-bois-visionary-infographics-180970826/</a>
<li>20 minute discussion of Du Bois and Chalabi charts</li>
<li>30 minute re-draw of one chart from reading</li>
<li>30 minute sharing and reflection</li>
</ul>
</li>
<li><strong><em>50 minutes:</em></strong><em> Visual exploration activity &amp; discussion:</em> Exploring and discussing <a href="https://lynchinginamerica.eji.org/explore">Racial Terror Lynchings</a> map
<ul>
<li>15 minute individual exploration</li>
<li>15 minute pair discussion</li>
<li>20 minute whole class discussion</li>
</ul>
</li>
</ul>
<h3>Optional After-Class Reading</h3>
<ul>
<li>Wainer, Howard. <em>Graphic Discovery: A Trout in the Milk and Other Visual Adventures</em>. Princeton: Princeton University Press, 2013. (selections)</li>
</ul>
<h2>Day 3: Contemporary Problematic Data: Politics and Culture</h2>
<h3>Morning 3: Creating Culturally and Politically Sensitive Visualizations</h3>
<h4>9:00am to 12pm (3 hours)</h4>
<ul>
<li><strong><em>30 minutes: </em></strong><em>Reflection and integration group discussion</em></li>
<li><strong><em>70 minutes:</em></strong><em> Visual exploration activity &amp; discussion:</em> Exploring and discussing <a href="http://www.monroeworktoday.org/explore/">Map of White Supremacist Mob Violence</a> compare with Racial Terror Lynchings
<ul>
<li>20 minute individual exploration</li>
<li>20 minute pair discussion</li>
<li>30 minute whole class discussion</li>
</ul>
</li>
<li><strong><em>10 minutes: </em></strong><em>Break</em></li>
</ul>
<h3>Afternoon 3: Discussion and Project Time</h3>
<h4>1:30pm to 4:00pm (2.5 hours)</h4>
<ul>
<li><strong><em>10 minutes:</em></strong> Introduction and instructions for afternoon&rsquo;s activities
<ul>
<li>Chart Suggestions handout</li>
<li>Color handout</li>
</ul>
</li>
<li><strong><em>140 minutes:</em></strong><em> Visualization activity: </em>Creating visualization plots (using provided, pre-made R codes and/or analog versions) based on the mapping projects using the data from Monroe Work Today</li>
<li><em>Project time:</em> apply principles and practices learned so far to your own treacherous data, creating a visualization using R, pen and paper, Raw Graphs (<a href="http://app.rawgraphs.io/">http://app.rawgraphs.io/</a>) or Excel</li>
</ul>
<h3>Optional After-Class Reading</h3>
<ul>
<li>Hepworth, K. J., Church, C. 2018., &ldquo;Racism in the Machine: Visualization Ethics in Digital Humanities Projects&rdquo;. <em>Digital Humanities Quarterly</em>. 12.4.</li>
</ul>
<h2>Day 4: Ideologically Laden Data: Propaganda and Polemics</h2>
<h3>Morning 4: Becoming Acquainted with the Mores of Data Collection and Visualization</h3>
<h4>9:00am to 12pm (3 hours)</h4>
<ul>
<li><strong><em>15 minutes: </em></strong><em>Reflection and integration group discussion </em></li>
<li><strong><em>30 minutes:</em></strong><em> Reading and discussion:</em> &ldquo;Map Generalizations: Little White Lies and Lots of Them&rdquo; in Monmonier M., <em>How to Lie With Maps</em>. University of Chicago, 1996
<ul>
<li>10 mins reading</li>
<li>10 mins discussion about the necessity but problematics of white lies</li>
<li>30 mins scavenger hunt for
<ul>
<li>Big lies</li>
<li>Little lies</li>
<li>How many little lies are ok?</li>
</ul>
</li>
<li>30 mins present findings</li>
</ul>
</li>
<li><strong><em>120 minutes:</em></strong><em> Discussion and Activity: Explore the data at the following sites:</em>
<ul>
<li><a href="http://www.fatalencounters.org/">Fatal Encounters</a></li>
<li><a href="https://www.washingtonpost.com/graphics/2018/national/police-shootings-2018/?utm_term=.854129d640cc">Fatal Force</a></li>
<li><a href="https://www.theguardian.com/us-news/ng-interactive/2015/jun/01/the-counted-police-killings-us-database">The Counted</a></li>
</ul>
</li>
<li>Which one presents the data in the most ethical way? Why?</li>
</ul>
<h2>Afternoon 4: Discussion and Project Time</h2>
<h3>1:30pm to 4:00pm (2.5 hours)</h3>
<ul>
<li><strong><em>150 minutes: </em></strong><em>Visualization activity of choice -Three data source options, can be analog or digital</em>
<ul>
<li>Option 1: Continue Monroe Work Today visualization</li>
<li>Option 2: Fatal Encounters visualization</li>
<li>Option 3: Your own data</li>
</ul>
</li>
<li><strong><em>50 minutes:</em></strong> Show-and-tell and reflection - show iteration, final product, and discuss ethical considerations</li>
</ul>
<p>&nbsp;</p>
<h2>Day 5: Defining Position Statements: Taming Treacherous Data</h2>
<h3>Morning 5: Framing your own visualization practice through position statements</h3>
<h4>9:00am to 12:00pm (3 hours)</h4>
<ul>
<li><strong><em>30 minutes: </em></strong><em>Reflection and integration group discussion</em></li>
<li><strong><em>60 minutes: </em></strong><em>Ensuring Ethical Use of Data</em>
<ul>
<li><strong><em>30 minutes: </em></strong><em>Documentation: </em>Ethical Visualization Workflow</li>
<li><strong><em>30 minutes</em></strong>: <a href="http://www.monroeworktoday.org/extras/files/MOU.pdf">Memos of Understanding</a></li>
</ul>
</li>
<li><strong><em>60 minutes: </em></strong><em>Activity: </em>Writing 500-1000 word position statements on your own visualization practice, based on socio-cultural considerations of their subject and audience.</li>
</ul>
<p>&nbsp;</p>