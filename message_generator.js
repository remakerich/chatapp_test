function getRandomMessage() {
  let index = Math.floor(Math.random() * textVariants.length);
  let randomText = textVariants[index];
  let message = {
    text: randomText,
    isIncoming: Math.random() < 0.5,
  };

  return message;
}

let textVariants = [
  "Рандомное сообщение",
  "select a random element",
  "Привет!",
  "implements the above approach",
  "австралийская теннисистка, победительница 62",
  "Окончив Московский архитектурный институт",
  "Пара шафрановых желтушек",
  "List of Latin phrases",
  "你跟我一起去吗？",
];
