FROM arm64v8/rakudo-star
RUN apt-get update
RUN apt-get install -y libpq-dev
RUN zef install UUID::V4     --force --/test
RUN zef install CSS::Writer  --force --/test
RUN zef install CSS::Nested  --force --/test
RUN zef install Cro          --force --/test
RUN zef install 'Red:api<2>' --force --/test
RUN zef install Cromponent   --force --/test
COPY . /app
WORKDIR /app
RUN zef install .
RUN blog create-db --populate
CMD ["blog", "run-web"]
