import IntroTemplate from "./intro-template";

const FirstScreen = () => {
  return (
    <IntroTemplate
      image={require('@/assets/images/intro1.png')}
      title="Track Your Expenses"
      description="Monitor your spending habits and stay in control."
      next="/intro/second_screen"
    />
  );
};

export default FirstScreen;
