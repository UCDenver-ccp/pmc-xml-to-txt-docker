# pmc-xml-to-txt-docker
Docker container for converting articles in the Pubmed Central XML format to plain text

The container makes use of code from the [CCP_NLP doc2txt module](https://github.com/UCDenver-ccp/ccp-nlp/tree/master/ccp-nlp-doc2txt). Note that a version of this container has been published on [DockerHub](https://hub.docker.com/repository/docker/ucdenverccp/nxml2txt).


### To convert nxml files to text:
  1. create a local directory that contains the nxml files you want to convert to text: /path/to/nxml
  2. create a local directory where the resulting text files wil be stored: /path/to/txt
  3. then run the following:

```
docker run --rm -v /path/to/nxml:/home/dev/input  -v /path/to/txt:/home/dev/output ucdenverccp/nxml2txt:0.1
```

  4. After running, converted text files should be in /path/to/txt/
     The text files will be compressed, and will have a `.utf8.gz` file suffix. There will also be an accompanying annotation file for each processed XML file (denoted by the `.ann.gz` file suffix) that catalogs character offsets within the document for document sections, e.g. `ARTICLE_TITLE|0|82` indicates the article title is located between characters 0 and 82.


### To Build the image (optional since it is available on DockerHub)
From the root directory of this project, run the following command:
```
docker build -t ucdenverccp/nxml2txt:[VERSION] .
```
 
